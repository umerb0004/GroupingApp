class UploadsController < ApplicationController
  def index
  end

  def create
    if file_exist?
      ImportGroupsService.new(file_param).import_csv
      flash[:success] = 'File uploaded'
      redirect_to root_path
    else
      flash[:error] = 'File upload failed.'
      redirect_to uploads_path
    end

  end

  private

  def file_exist?
    file_param.present? && file_param.content_type.eql?('text/csv')
  end

  def file_param
    params.require(:file_upload)
  end
end
