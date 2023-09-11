module ApplicationHelper
  def membership_roles(group, user)
    group.group_memberships.where(user_id: user.id)
                               .distinct.pluck(:role)
  end

  def organizers_names(group)
    full_names = group.organizers_full_names
     
    full_names.blank? ? 'N/A' : full_names  
  end
end
