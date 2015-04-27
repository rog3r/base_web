class RoleUser < ActiveRecord::Base
  self.table_name = 'roles_users'
  belongs_to :user
  belongs_to :role
end

# == Schema Information
#
# Table name: roles_users
#
#  role_id :integer
#  user_id :integer
#
# Indexes
#
#  fk__roles_users_role_id                   (role_id)
#  fk__roles_users_user_id                   (user_id)
#  index_roles_users_on_role_id_and_user_id  (role_id,user_id)
#
