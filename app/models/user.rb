class User < ActiveRecord::Base
  has_many :role_users
  has_many :roles, through: :role_users
  has_many :abilities, through: :roles

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
  
  
  scope :except_admin, -> {
    joins(:roles).where.not(roles: { name: 'administrator'} )
  }

  ## Pundit -----------------------------------------------------------

  def admin? #TODO - rever comparação case insensitive
    roles.pluck(:name).include? 'administrator'  #roles.map(&:name).include? 'Administrator' #roles.where(name: 'administrator').exists?
  end

## Pundit end

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


  #----- Custom Devise Locked ---------
  #
  def active_for_authentication?
    super && !locked
  end

  def inactive_message
    !locked ? super : :locked
  end

  ## ----------------------------------


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
