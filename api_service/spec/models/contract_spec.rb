require 'rails_helper'

RSpec.describe Contract, type: :model do
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:start_date) }
  it { is_expected.to validate_presence_of(:end_date) }
  it { is_expected.to validate_presence_of(:expiry_date) }
end
