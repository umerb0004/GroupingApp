class User < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships

  validates :first_name, :last_name, presence: true

  def self.organizers_full_names
    includes(:group_memberships).where(group_memberships: { role: :organizer })
                                .distinct
                                .pluck(Arel.sql("first_name || ' ' || last_name"))
                                .join(', ')
  end
end
