require 'spec_helper'

RSpec.describe ::SeatService::Get, type: :model do

  context 'when params is valid' do
    [:example_test_case, :simple_test_case, :complex_test_case, :empty_passenger_test_case, :full_passengers_test_case].each do |test_case|
      context "when #{test_case}" do
        let(:params) { JSON.parse(File.read("spec/fixtures/seats/#{test_case}/request.json")) }
        let(:expected_result) { JSON.parse(File.read("spec/fixtures/seats/#{test_case}/response.json")) }

        it 'return expected result' do
          expect(described_class.new(params["layout"], params["total_passengers"]).call).to eq(expected_result)
        end
      end
    end
  end

  context 'when params is invalid' do
    Dir.glob('spec/fixtures/seats/invalid_params_test_case/*.json').each do |test_case_file|
      context "when #{test_case_file}" do
        let(:params) { JSON.parse(File.read(test_case_file)) }

        it 'raise BadParameterError' do
          expect{ described_class.new(params["layout"], params["total_passengers"]).call }.to raise_error(an_instance_of(::Services::BadParameterError))
        end
      end
    end
  end
end
