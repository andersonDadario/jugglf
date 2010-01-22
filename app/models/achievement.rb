# == Schema Information
#
# Table name: achievements
#
#  id          :integer(4)      not null, primary key
#  armory_id   :integer(4)
#  category_id :integer(4)
#  title       :string(255)
#  icon        :string(255)
#

class Achievement < ActiveRecord::Base
  attr_accessible :armory_id, :category_id, :title, :icon

  has_many :completed_achievements, :dependent => :destroy
  has_many :members, :through => :completed_achievements

  validates_presence_of :armory_id
  validates_presence_of :category_id
  validates_presence_of :title

  def to_s
    "#{self.title}"
  end
end
