require 'spec_helper'

describe CXML::Response do

  it { should respond_to :id }
  it { should respond_to :status }
  it { should respond_to :punch_out_setup_response }

  let(:parser) { CXML::Parser.new }
  let(:data) { parser.parse(fixture('response_status_200.xml')) }
  let(:doc) { CXML::Document.new(data) }
  let(:response){doc.response}
  let(:builder) {doc.render}

  describe '#initialize' do
    it "sets the mandatory attributes" do
      response.status.should be_an_instance_of CXML::Status
      response.punch_out_setup_response.should be_an_instance_of CXML::PunchOutSetupResponse
    end
  end

  describe '#render' do
    let(:output_xml) {builder.to_xml}
    let(:output_data) {parser.parse(output_xml)}
    let(:punch_out_order_message_output_data) { output_data['Message']['PunchOutOrderMessage'] }

    context "when a valid response is rendered" do
      let(:data) { parser.parse(fixture('response_status_200.xml')) }

      it "returns xml content" do
        output_xml.should_not be_nil
      end

      it 'outputs the response with a valid status code' do
        output_data["Response"].should_not be_empty
        output_data["Response"]["PunchOutSetupResponse"].should_not be_empty
        output_data["Response"]["Status"]["code"].should == "200"
      end

      it "outputs the punch out setup response" do
        output_data["Response"]["PunchOutSetupResponse"].should_not be_empty
      end

    end

    context "when a invalid response is rendered" do
      let(:data) { parser.parse(fixture('response_status_400.xml')) }

      it "returns xml content" do
        output_xml.should_not be_nil
      end

      it 'outputs the response with a valid status code' do
        output_data["Response"].should_not be_empty
        output_data["Response"]["Status"]["code"].should == "400"
      end
    end

  end


end
