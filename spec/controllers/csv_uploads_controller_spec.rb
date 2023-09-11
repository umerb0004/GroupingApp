wrequire 'rails_helper'

RSpec.describe CsvUploadsController, type: :controller do
  describe 'POST #create' do
    context 'with valid file' do
      let(:csv_file) { fixture_file_upload('Meetup.csv', 'text/csv') }

      it 'imports CSV data' do
        expect do
          post :create, params: { file_upload: csv_file }
        end.to change(GroupMembership, :count).by(3)
        expect(flash[:success]).to be_present
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with missing file' do
      it 'shows error message' do
        post :create
        expect(flash[:error]).to be_present
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
