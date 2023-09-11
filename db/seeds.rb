require 'faker'

users = []
(1..10).each do |id|
  users << User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

groups = []
(1..3).each do |id|
  groups << Group.create!(
    name: Faker::Company.name
  )
end

groups.each do |group|
  users.sample(3).each do |user|
    GroupMembership.create!(
      user: user,
      group: group,
      role: GroupMembership.roles.keys.sample
    )
  end
end

puts 'Seed data created successfully.'
