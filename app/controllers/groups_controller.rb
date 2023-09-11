class GroupsController < ApplicationController
  before_action :set_group, only: %i[edit update destroy]
  before_action :set_users, only: %i[new edit]

  def index
    @groups = Group.ordered_by_created_at_asc
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(name: group_params[:name])

    if contains_any_user
      if @group.save
        ImportGroupsService.manage_group_memberships(:create_memberships, @group, group_params)
        redirect_to_groups_path('created')
      else
        respond_to do |format|
          flash.now[:error] = 'Unable to create group.'
          format.turbo_stream
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    else
      render_new_action
    end
  end

  def update
    if contains_any_user
      if @group.update(name: group_params[:name])
        ImportGroupsService.manage_group_memberships(:update_memberships, @group, group_params)
        redirect_to_groups_path('updated')
      else
        respond_to do |format|
          flash.now[:error] = 'Unable to update group.'
          format.turbo_stream
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    else
      render_new_action
    end
  end

  def destroy
    if @group.destroy
      redirect_to_groups_path('destroyed')
    else
      respond_to do |format|
        flash.now[:error] = 'Cannot destroy the group.'
        format.turbo_stream
        format.html { redirect_to groups_url, status: :unprocessable_entity }
      end
    end
  end  

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def set_users
    @users = User.all
  end

  def redirect_to_groups_path(action)
    respond_to do |format|
      flash.now[:success] = "Group #{action} successfully."
      format.turbo_stream
      format.html { redirect_to groups_path, status: :ok }
    end
  end

  def render_new_action
    respond_to do |format|
      flash.now[:error] = 'At least one user is required.'
      format.turbo_stream
      format.html { render :edit, status: :unprocessable_entity }
    end
  end

  def contains_any_user
    group_params[:organizer].present? || group_params[:presenter].present? ||
    group_params[:participant].present?
  end

  def group_params
    params.require(:group).permit(:name, organizer: [], presenter: [], participant: [])
  end
end
