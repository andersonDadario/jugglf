class Loot < ActiveRecord::Base
  attr_accessible(:item, :item_id, :item_name, :price, :purchased_on,
                  :best_in_slot, :situational, :rot, :member, :member_id,
                  :member_name, :raid, :raid_id)

  belongs_to :item, :counter_cache => true
  belongs_to :member, :counter_cache => true
  belongs_to :raid, :counter_cache => true

  validates_numericality_of :price, :allow_nil => true

  scope :recent, lambda { where("purchased_on >= ?", 2.weeks.ago) }

  before_save :set_purchased_on

  alias_method :buyer, :member

  # FIXME: Misnomer. Should be item_string, or something like that
  def item_name
    return if self.item_id.nil?

    # TODO: Redundant now
    if self.item_id.present?
      self.item_id
    else
      self.item.name
    end
  end
  def item_name=(value)
    self.item = Item.find_by_name_or_id(value)
  end

  def member_name
    self.member.name unless self.member_id.nil?
  end
  def member_name=(value)
    self.member = Member.find_by_name(value)
  end

  def affects_loot_factor?
    return false if self.purchased_on.blank?

    self.purchased_on >= 52.days.until(Date.today)
  end

  def adjusted_price
    ( self.rot? ) ? 0.50 : self.price
  end

  # Returns the value of the given purchase type (Normal, Rot, Situational, Best In Slot)
  def has_purchase_type?(purchase_type)
    purchase_type = purchase_type.to_s.gsub(' ', '_').strip

    if purchase_type.to_s.match(/^normal/i)
      return (not self.best_in_slot? and not self.situational?)
    else
      return self.send(purchase_type) if self.respond_to?(purchase_type)
    end
  end

  private
    def set_purchased_on
      if self.purchased_on.nil? and not self.raid_id.nil?
        self.purchased_on = self.raid.date
      end
    end
end
