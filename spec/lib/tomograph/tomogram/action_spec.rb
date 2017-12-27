require 'spec_helper'
require 'tomograph/tomogram/action'

RSpec.describe Tomograph::Tomogram::Action do
  describe '#find_responses' do
    let(:status) { '' }
    let(:responses) { [{ 'status' => status }] }

    subject do
      described_class.new(
        path: '',
        method: '',
        request: '',
        responses: responses,
        resource: '',
        group_title: '',
        resource_title: '',
        action_title: ''
      )
    end

    it 'returns responses' do
      expect(subject.find_responses(status: status)).to eq(responses)
    end
  end
end
