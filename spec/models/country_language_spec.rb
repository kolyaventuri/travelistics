require 'rails_helper'

describe CountryLanguage, type: :model do
  it { is_expected.to belong_to(:country) }
  it { is_expected.to belong_to(:language) }
end