require 'csv'

class ImportGroupsService
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def import_csv
    CSV.foreach(@file.path, headers: true) do |row|
      user = User.find_or_create_by(first_name: row['First Name'], last_name: row['Last Name'])
      group = Group.find_or_create_by(name: row['Group Name'])

      group_membership = GroupMembership.find_or_create_by(user: user, group: group)
      group_membership.update(role: row['Role in Group'].downcase)
    end
  end

  def self.manage_group_memberships(key, group, group_params)
    GroupMembership.roles.each do |role_key, role_value|
      send(key, group, group_params[role_key], role_value)
    end
  end

  private

  def self.update_memberships(group, user_ids, role)
    user_ids = user_ids&.map(&:to_i) || []
    existing_user_ids = group.group_memberships.where(role: role).pluck(:user_id)
    
    members_to_remove = existing_user_ids - user_ids
    
    group.group_memberships.where(user_id: members_to_remove, role: role)&.destroy_all
    
    memberships_to_add = user_ids - existing_user_ids

    create_memberships(group, memberships_to_add, role)
  end

  def self.create_memberships(group, user_ids, role)
    user_objects = user_ids&.map { |user_id| { user_id: user_id, role: role } }
    
    group.group_memberships.create(user_objects)
  end
end
