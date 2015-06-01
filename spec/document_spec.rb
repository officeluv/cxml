require 'spec_helper'

describe CXML::Document do

  shared_examples_for :document_has_mandatory_values do
    it "sets the mandatory attributes" do
      doc.version.should eq(CXML::Protocol::VERSION)
      doc.payload_id.should_not be_nil
    end
  end

  shared_examples_for :document_has_a_header do
    it "sets the header attributes" do
      doc.header.should be_a CXML::Header
    end
  end

  shared_examples_for :document_has_a_timestamp do
    it "sets the timestamp attributes" do
      doc.timestamp.should be_a Time
      doc.timestamp.should eq(Time.parse('2012-09-04T02:37:49-05:00'))
    end
  end

  shared_examples_for :document_render_defaults do
    it "returns xml content" do
      output_xml.should_not be_nil
    end

    it 'returns xml content with a header xml node' do
      output_data["Header"].should_not be_empty
    end

  end

  let(:parser) { CXML::Parser.new }

  it { should respond_to :version }
  it { should respond_to :payload_id }
  it { should respond_to :timestamp }
  it { should respond_to :header }
  it { should respond_to :request }
  it { should respond_to :response }
  it { should respond_to :punch_out_order_message}
  it { should respond_to :xml_lang}

  describe '#initialize' do

    let(:doc) { CXML::Document.new(data) }

    context "when a request document is passed" do

      let(:data) { parser.parse(fixture('request_doc.xml')) }
      include_examples :document_has_mandatory_values
      include_examples :document_has_a_header
      include_examples :document_has_a_timestamp

      it 'sets the correct document node attributes' do
        doc.header.should be_a CXML::Header
        doc.request.should be_a CXML::Request

        doc.response.should be_nil
        doc.punch_out_order_message.should be_nil
      end
    end

    context "when a response document is passed" do

      let(:data) { parser.parse(fixture('response_status_200.xml')) }
      include_examples :document_has_mandatory_values
      include_examples :document_has_a_timestamp

      it 'sets the correct document node attributes' do
        doc.response.should be_a CXML::Response

        doc.header.should be_nil
        doc.request.should be_nil
        doc.punch_out_order_message.should be_nil
      end
    end


    context "when a punch out order message is passed" do

      let(:data) { parser.parse(fixture('punch_out_order_message_doc.xml')) }
      include_examples :document_has_mandatory_values
      include_examples :document_has_a_header
      include_examples :document_has_a_timestamp

      it 'sets the correct document node attributes' do
        doc.header.should be_a CXML::Header
        doc.punch_out_order_message.should be_a CXML::PunchOutOrderMessage

        doc.request.should be_nil
        doc.response.should be_nil
      end

    end

  end

  describe '#render' do

    let(:doc) { CXML::Document.new(data) }
    let(:builder) {doc.render}
    let(:output_xml) {builder.to_xml}
    let(:output_data) {parser.parse(output_xml)}

    it { should respond_to :render}

    context "when a request document is rendered" do
      let(:data) { parser.parse(fixture('request_doc.xml')) }
      include_examples :document_render_defaults
    end

    context "when a valid response is rendered" do
      let(:data) { parser.parse(fixture('response_status_200.xml')) }
      it "returns xml content" do
        output_xml.should_not be_nil
      end

      it 'outputs the response with a valid status code' do
        output_data["Response"].should_not be_empty
        output_data["Response"]["Status"]["code"].should == "200"
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

    context "when a punch out order message document is rendered" do
      let(:data) { parser.parse(fixture('punch_out_order_message_doc.xml')) }
      include_examples :document_render_defaults

      it 'outputs the punch out order message xml' do
        output_data["Message"].should_not be_empty
        output_data["Message"]["PunchOutOrderMessage"].should_not be_empty
      end
    end

  end

end

