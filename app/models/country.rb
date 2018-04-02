# Country
class Country < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :code
  validates_presence_of :side_of_road

  validates_uniqueness_of :code

  belongs_to :currency
end