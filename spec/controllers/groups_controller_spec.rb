require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      group = FactoryBot.create(:group)
      get :show, params: { id: group.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      group = FactoryBot.create(:group)
      get :edit, params: { id: group.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new group' do
        expect do
          post :create, params: { group: FactoryBot.attributes_for(:group) }
        end.to change(Group, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'does not create a new group' do
        expect do
          post :create, params: { group: { name: '' } }
        end.not_to change(Group, :count)

        expect(response).to render_template(:new) 
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the group' do
        group = FactoryBot.create(:group)
        new_name = 'Updated Group Name'
        patch :update, params: { id: group.id, group: { name: new_name } }
        group.reload
        expect(group.name).to eq(new_name)
      end
    end

    context 'with invalid params' do
      it 'does not update the group' do
        group = FactoryBot.create(:group)
        invalid_name = ''
        patch :update, params: { id: group.id, group: { name: invalid_name } }
        group.reload
        expect(group.name).not_to eq(invalid_name)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the group' do
      group = FactoryBot.create(:group)
      expect do
        delete :destroy, params: { id: group.id }
      end.to change(Group, :count).by(-1)
    end
  end
end
