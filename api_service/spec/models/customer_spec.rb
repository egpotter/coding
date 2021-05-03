require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  describe 'email' do
    it { is_expected.to allow_value("email@addresse.foo").for(:email) }
    it { is_expected.to_not allow_value("foo@").for(:email) }
  end
 end
