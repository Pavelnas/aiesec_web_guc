class Faction < ApplicationRecord
  belongs_to :member
  has_many :ogv
end
