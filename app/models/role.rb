class Role < ActiveRecord::Base
  has_many :role_users
  has_many :users, through: :role_users


  has_many :ability_roles, dependent: :destroy
  has_many :abilities, through: :ability_roles
  accepts_nested_attributes_for :ability_roles, update_only: true

  validates_presence_of :name

  #
  #
  #
  #
  #has_many :roles_abilities, :dependent => :destroy
  #has_many :abilities, through: :roles_abilities
  #accepts_nested_attributes_for :ability_roles, :update_only => true



  ##
  ## roleæ–°è¦ä½œæˆæ™‚ã«abilityã®ãƒã‚§ãƒƒã‚¯ãŒ0ä»¶ã ã£ãŸã‚‰ã‚¨ãƒ©ãƒ¼
  ##
  #validates_each :ability do |record, attr, value|
  #  if record.roles_abilities.blank?
  #    record.errors.add attr, 'æ¨©é™ã¯1ä»¶ä»¥ä¸Šé¸æŠžã—ã¦ãã ã•ã„'
  #  end
  #end
  #
  #def ability
  #  Ability.ability_hash_with_id self.roles_abilities.map(&:ability_id)
  #end
  #
  #def ability_id_to_a
  #  roles_abilities.map(&:ability_id)
  #end
  #
  #def index_by_ability_id
  #  roles_abilities.index_by(&:ability_id)
  #end
  #
  ##
  ## roleã«ç´ã¥ãability_idã‚’æ›´æ–°ã™ã‚‹éš›ã€
  ##   * ä¸è¦ã«ãªã‚‹roles_abilities.ability_idãŒå­˜åœ¨ã—ãŸã‚‰ç‰©ç†å‰Šé™¤
  ##   * æ–°ã—ãä½œæˆã™ã‚‹ã‚‚ã®ã¯æ–°è¦ä½œæˆ
  ##   * æ—¢ã«ã‚ã‚‹ã‚‚ã®ã¯ä½•ã‚‚ã—ãªã„
  ##
  #def destroy_and_update(attrs)
  #  ActiveRecord::Base.transaction do
  #    destroy_old_abilities(attrs)
  #    raise ActiveRecord::Rollback unless update(push_current_roles_abilities_id attrs)
  #    reload
  #    true
  #  end
  #rescue => e
  #  logger.error e.message
  #  e.backtrace.each { |line| logger.error line }
  #  false
  #end
  #
  ##
  ## attrsã®ability_idã«ç¾åœ¨ã®ability_idãŒå…¥ã£ã¦ã„ãŸå ´åˆã€
  ## hashã«roles_abilities.idã‚’è¿½åŠ ã™ã‚‹
  ##
  ## æ›´æ–°æ™‚ã®ãƒªã‚¯ã‚¨ã‚¹ãƒˆãƒ‘ãƒ©ãƒ¡ãƒ¼ã‚¿ã‚‚ability_idã®ã¿ã ãŒã€
  ## æ—¢ã«å­˜åœ¨ã™ã‚‹ability_idãŒå…¥ã£ã¦ã‚‹ãƒ¬ã‚³ãƒ¼ãƒ‰ã«ã¯ä½•ã‚‚ã—ãŸããªã„ã€‚
  ## ãã®ãŸã‚ã€updateã‚’å‘¼ã¶éš›ã«roles_abilities.idã‚’è¿½åŠ ã™ã‚‹ã€‚
  ##
  #def push_current_roles_abilities_id(attrs)
  #  attrs["roles_abilities_attributes"].each do |item|
  #    if index_by_ability_id.include? item["ability_id"].to_i
  #      item["id"] = index_by_ability_id[item["ability_id"].to_i].id.to_s
  #    end
  #  end
  #
  #  attrs
  #end
  #
  ##
  ## å‰Šé™¤ã™ã‚‹ability_idãŒã‚¤ãƒ³ã‚¹ã‚¿ãƒ³ã‚¹ã®roles_abilities.ability_idã¨
  ## ä¸€è‡´ã—ã¦ã„ãŸã‚‰ç‰©ç†å‰Šé™¤
  ##
  #def destroy_old_abilities(attrs)
  #  destroy_id = get_destroy_id(attrs)
  #
  #  unless destroy_id.blank?
  #    RolesAbility.where(role_id: id).where(ability_id: destroy_id).delete_all
  #  end
  #end
  #
  ##
  ## roleæ›´æ–°æ™‚ã«å‰Šé™¤ã™ã‚‹ability_idã‚’å–å¾—ã—ã¦é…åˆ—ã§è¿”ã™
  ## [ç¾åœ¨ã®ability_id] - [ãƒ‘ãƒ©ãƒ¡ãƒ¼ã‚¿ã§æ¸¡ã•ã‚Œã¦ããŸability_id]
  ## æ›´æ–°ç„¡ã—ã®å ´åˆã€é…åˆ—ãŒè¿”ã‚‹
  ##
  ## privateãƒ¡ã‚½ãƒƒãƒ‰ã§ã‚‚ã„ã„ã‚ˆã†ãªæ°—ãŒã™ã‚‹ãŒã€
  ## æ­£ã—ãå‰Šé™¤ã™ã‚‹idã‚’å–å¾—ã—ã¦ã‚‹ã‹ãƒ†ã‚¹ãƒˆã—ãŸã‹ã£ãŸ
  ##
  #def get_destroy_id(attrs)
  #  ability_id_to_a - attrs_to_array(attrs)
  #end
  #
  #scope :except_admin, -> {
  #  select(:id, :name).joins(:roles_abilities).joins(:abilities).where.not(abilities: { domain: "admin" }).uniq
  #}
  #
  #private
  #
  ##
  ## ãƒ‘ãƒ©ãƒ¡ãƒ¼ã‚¿ã§æ¸¡ã•ã‚ŒãŸability_idã‚’é…åˆ—ã§è¿”ã™
  ##
  #def attrs_to_array(attrs)
  #  raise ArgumentError if attrs_is_invalid?(attrs)
  #  attrs["roles_abilities_attributes"].map{ |item| item["ability_id"].to_i }
  #rescue ArgumentError
  #  errors.add "Ability", "æ¨©é™ã¯1ä»¶ä»¥ä¸Šé¸æŠžã—ã¦ãã ã•ã„"
  #  raise ActiveRecord::Rollback
  #end
  #
  #def attrs_is_invalid?(attrs)
  #  !attrs.include?("roles_abilities_attributes") or attrs["roles_abilities_attributes"].blank?
  #end









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
