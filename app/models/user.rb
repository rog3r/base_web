class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :role_users
  has_many :roles, through: :role_users


  devise :database_authenticatable,
         #:registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable,
         :lockable #, :timeoutable

  validates :name, presence: true

  before_create :skip_notification! 
  after_create :skip_confirmation!




  def roles_abilities

  end


  ## Pundit -----------------------------------------------------------
  #
  #def ability
  #  Ability.ability_hash self.role.roles_abilities.map(&:ability_id)
  #end
  #
  #def admin?
  #  ability.include? 'admin'
  #end
  #
  #scope :except_admin, -> {
  #  joins(:role).where.not(roles: { name: 'administrator'} )
  #}

## Pundit end



 #http://blog.joshsoftware.com/2012/10/23/dynamic-roles-and-permissions-using-cancan/
  #load the permissions for the current user so that UI can be manipulated
  #def load_permissions
  #  @current_permissions = current_user.role.permissions.collect{|i| [i.subject_class, i.action]}
  #end

  #http://blog.endpoint.com/2011/11/advanced-rights-roles-management-rails.html
  #def can_do_method?(method)
  #  self.rights.detect { |r| r.name == method }
  #end
  # Usage: current_user.can_do_method?("example_right1")

  #Converts it to a string camel cases it.
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
 

  def self.ransackable_attributes(auth_object = nil)
    %w( name email ) + _ransackers.keys
  end


  def to_s
    email
  end

  def skip_notification!
    self.skip_confirmation_notification! #if Rails.env.development?
  end

  def skip_confirmation!
    self.confirm! #if Rails.env.development? 
    save! 
  end


  #----- Custom locked ---------
  #
  def active_for_authentication?
    super && !locked
  end

  def inactive_message
    !locked ? super : :locked
  end

  ## -------


end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  locale                 :string
#  locked                 :boolean          default(FALSE)
#  name                   :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
