require 'rails_helper'

describe Currency, type: :model do
  it { is_expected.to validate_presence_of(:code) }

  it { is_expected.to have_many(:countries) }
end