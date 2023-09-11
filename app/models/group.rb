class Group < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships

  validates :name, presence: true

  scope :ordered_by_created_at_asc, -> { order(created_at: :asc) }

  delegate :organizers_full_names, to: :users
end
