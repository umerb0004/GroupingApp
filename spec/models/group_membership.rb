require 'rails_helper'

RSpec.describe GroupMembership, type: :model do
  describe 'validations and associations' do
    it 'belongs to a user' do
      association = GroupMembership.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a group' do
      association = GroupMembership.reflect_on_association(:group)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has a valid role enumeration' do
      roles = GroupMembership.roles.keys
      expect(roles).to include('organizer', 'presenter', 'participant')
    end
  end
end
