# frozen_string_literal: true

require 'spec_helper'

describe CXML::Response do
  it { should respond_to :id }
  it { should respond_to :status }
  it { should respond_to :punch_out_setup_response }

  let(:data) { CXML::Parser.new(data: fixture('response_status_200.xml')).parse }
  let(:doc) { CXML::Document.new(data) }
  let(:response) { doc.response }

  describe '#initialize' do
    it 'sets the mandatory attributes' do
      response.status.should be_an_instance_of CXML::Status
      response.punch_out_setup_response.should be_an_instance_of CXML::PunchOutSetupResponse
    end
  end

  describe '#render' do
    let(:output_xml) { doc.to_xml }
    let(:output_data) { CXML::Parser.new(data: output_xml).parse }

    context 'when a valid response is rendered' do
      let(:data) { CXML::Parser.new(data: fixture('response_status_200.xml')).parse }

      it 'returns xml content' do
        output_xml.should_not be_nil
      end

      it 'outputs the response with a valid status code' do
        output_data[:response].should_not be_empty
        output_data[:response][:punch_out_setup_response].should_not be_empty
        output_data[:response][:status][:code].should == '200'
      end

      it 'outputs the punch out setup response' do
        output_data[:response][:punch_out_setup_response].should_not be_empty
      end
    end

    context 'when a invalid response is rendered' do
      let(:data) { CXML::Parser.new(data: fixture('response_status_400.xml')).parse }

      it 'returns xml content' do
        output_xml.should_not be_nil
      end

      it 'outputs the response with a valid status code' do
        output_data[:response].should_not be_empty
        output_data[:response][:status][:code].should == '400'
      end
    end
  end
end
