class RolesController < ApplicationController 
  before_action :pundit_auth
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_action :set_abilities, only: [ :new, :edit, :edit_multiple]

  respond_to :html
  responders :flash
  
  
  def index
    @roles = build_basic_search(Role.except_admin) #Role.except_admin
  end

  def show
  end

  def new
    @role = Role.new
    @role.ability_roles.build
  end

  def edit
  end

  def create
    puts params.inspect
    @permissions = Ability.except_admin.group_by(&:domain)#@permissions = Permission.all
    @role = Role.create(role_params)
    params[:save_and_new] ? (respond_with @role, location: new_role_path) : (respond_with @role, location: roles_path)
  end

  def update
    @role.update(role_params)  #@role.destroy_and_update(role_params)
    respond_with @role , location: roles_path
  end

  def destroy
    @role.destroy
    respond_with @role
  end


  def edit_multiple
    @roles = build_basic_search(Role.except_admin)
  end

  def update_multiple
    puts params.inspect

    #params[:roles] = {} unless params.has_key?(:roles) # if all checkboxes unchecked.
    #Role.all.each do |role|
    #  # this allows for 0 permission checkboxes being checked for a role.
    #  unless params[:roles].has_key?(role.id.to_s)
    #    params[:roles][role.id] = { permission_ids: [] }
    #  end
    #end
    #@roles = Role.update(params[:roles].keys, params[:roles].values)
    #@roles.reject! { |r| r.errors.empty? }
    #if @roles.empty?
      redirect_to edit_multiple_roles_path
    #else
      #render :edit_multiple
    #end
  end


  private

  def set_role
    @role = Role.find(params[:id])
  end

  def set_abilities
    @permissions = Ability.except_admin.group_by(&:domain)#@permissions = Permission.all
  end

  def role_params
    params.require(:role).permit(:name, ability_ids: []) #, :_destroy)
  end

  def pundit_auth
    authorize Role.new
  end
end
