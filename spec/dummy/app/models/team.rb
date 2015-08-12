class Team < ActiveRecord::Base
  include DirtyNestedAttributes

  has_many :players
  has_one :coach
  accepts_nested_attributes_for :players, allow_destroy: true
  accepts_nested_attributes_for :coach
end
