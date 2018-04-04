# Trip
class Trip < ApplicationRecord
  validates_presence_of :name

  belongs_to :origin_country, class_name: Country
  belongs_to :destination_country, class_name: Country
end
