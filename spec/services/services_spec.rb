require 'spec_helper'

RSpec.describe ::Services::BadParameterError, type: :model do
  subject { described_class.new }
  it do
    is_expected.to be_a_kind_of(::Services::BadParameterError)
    is_expected.to be_a_kind_of(::Services::ServiceError)
    is_expected.to be_a_kind_of(::StandardError)
  end
end
