class AbilityRole < ActiveRecord::Base
  self.table_name = 'abilities_roles' #'ability_roles'
  belongs_to :role
  belongs_to :ability

  validates :role_id,
            presence: true,
            uniqueness: {scope: [:ability_id]}

  #https://github.com/onigra/pundit_sample/blob/master/spec/factories/ability.rb
  #validates :role_id,
  #          presence: true,
  #          uniqueness: {scope: [:role_id, :ability_id]}
end

# == Schema Information
#
# Table name: abilities_roles
#
#  id         :integer          not null, primary key
#  ability_id :integer
#  role_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  fk__abilities_roles_ability_id                   (ability_id)
#  fk__abilities_roles_role_id                      (role_id)
#  index_abilities_roles_on_ability_id_and_role_id  (ability_id,role_id)
#
