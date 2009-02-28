class Loot < ActiveRecord::Base
  # Relationships -------------------------------------------------------------
  belongs_to :member, :counter_cache => true
  alias_method :buyer, :member
  belongs_to :raid, :counter_cache => true
  belongs_to :item
  
  # Attributes ----------------------------------------------------------------
  
  # Validations ---------------------------------------------------------------
  
  # Callbacks -----------------------------------------------------------------
  
  # Class Methods -------------------------------------------------------------
  
  # Instance Methods ----------------------------------------------------------
  def affects_loot_factor?
    self.purchased_on >= 8.weeks.until(Date.today)
  end
  
  def adjusted_price
    ( self.rot? ) ? 0.50 : self.price
  end
end