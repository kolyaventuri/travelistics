class Currency < ApplicationRecord
  validates_presence_of :code

  has_many :countries
end