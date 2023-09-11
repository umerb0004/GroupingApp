require 'rails_helper'

RSpec.describe Group, type: :model do
  it 'is valid with valid attributes' do
    group = FactoryBot.build(:group)
    expect(group).to be_valid
  end

  it 'is not valid without a name' do
    group = FactoryBot.build(:group, name: nil)
    expect(group).to_not be_valid
  end

  it 'has many users through group memberships' do
    association = Group.reflect_on_association(:users)
    expect(association.macro).to eq(:has_many)
    expect(association.options[:through]).to eq(:group_memberships)
  end
end
