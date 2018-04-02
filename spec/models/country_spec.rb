require 'rails_helper'

describe Country, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_presence_of(:side_of_road) }

  it { is_expected.to validate_uniqueness_of(:code) }

  it { is_expected.to belong_to(:currency) }
  it { is_expected.to have_many(:country_languages) }
  it { is_expected.to have_many(:languages).through(:country_languages) }
end