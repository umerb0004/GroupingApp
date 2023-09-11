FactoryBot.define do
  factory :group_membership do
    user
    group
    role { GroupMembership.roles.keys.sample }

    trait :organizer do
      role { 'organizer' }
    end
  end
end
