require 'spec_helper'

RSpec.describe ::SeatService, type: :model do
  it do
    is_expected.to respond_to(:get)
  end
end
