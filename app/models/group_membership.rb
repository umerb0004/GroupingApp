class GroupMembership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum role: { organizer: 0, presenter: 1, participant: 2 }

  validates :user_id, :group_id, :role, presence: true
  validates :role, inclusion: { in: GroupMembership.roles.keys }
end
