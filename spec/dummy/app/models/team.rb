class Team < ActiveRecord::Base
  include DirtyAssociations
  has_many :players
  accepts_nested_attributes_for :players, allow_destroy: true
end
