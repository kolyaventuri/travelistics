require 'rails_helper'

describe Language, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:code) }

  it { is_expected.to validate_uniqueness_of(:code) }
end
