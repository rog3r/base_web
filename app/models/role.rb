class Role < ActiveRecord::Base
  has_many :role_users
  has_many :users, through: :role_users


  has_many :ability_roles, dependent: :destroy
  has_many :abilities, through: :ability_roles
  #accepts_nested_attributes_for :ability_roles, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :ability_roles, reject_if: :any_blank, allow_destroy: true

  validates  :name, presence: true, uniqueness: true

  scope :except_admin, -> {
    select(:id, :name).joins(:ability_roles).joins(:abilities).where.not(abilities: {domain: 'admin'}).uniq
  }

  def self.ransackable_attributes(auth_object = nil)
    %w( name email ) + _ransackers.keys
  end

end

# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_roles_on_name  (name)
#
