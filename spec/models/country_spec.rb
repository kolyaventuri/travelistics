require 'rails_helper'

describe Country, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_presence_of(:side_of_road) }

  it { is_expected.to validate_uniqueness_of(:code) }

  it { is_expected.to belong_to(:currency) }
end