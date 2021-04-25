# frozen_string_literal: true

require 'spec_helper'

describe CXML::Document do
  shared_examples_for :document_has_mandatory_values do
    it 'sets the mandatory attributes' do
      doc.version.should_not be_nil
      doc.payload_id.should_not be_nil
    end
  end

  shared_examples_for :document_has_a_header do
    it 'sets the header attributes' do
      doc.header.should be_a CXML::Header
    end
  end

  shared_examples_for :document_has_a_timestamp do
    it 'sets the timestamp attributes' do
      doc.timestamp.should be_a Time
      doc.timestamp.should eq(Time.parse('2012-09-04T02:37:49-05:00'))
    end
  end

  shared_examples_for :document_render_defaults do
    it 'returns xml content' do
      output_xml.should_not be_nil
    end

    it 'returns xml content with a header xml node' do
      output_data[:header].should_not be_empty
    end
  end

  it { should respond_to :version }
  it { should respond_to :payload_id }
  it { should respond_to :timestamp }
  it { should respond_to :header }
  it { should respond_to :request }
  it { should respond_to :response }
  it { should respond_to :message }
  it { should respond_to :xml_lang }
  it { should respond_to :request? }
  it { should respond_to :response? }
  it { should respond_to :message? }

  describe '#initialize' do
    let(:doc) { CXML::Document.new(data) }

    it 'can ingest from_xml' do
      doc = described_class.new.from_xml(fixture('response_status_200.xml'))
      doc.response.status.code.should eq(200)
    end

    context 'when a request document is passed' do
      let(:data) { CXML::Parser.new(data: fixture('request_doc.xml')).parse }
      include_examples :document_has_mandatory_values
      include_examples :document_has_a_header
      include_examples :document_has_a_timestamp

      it 'sets the correct document node attributes' do
        doc.header.should be_a CXML::Header
        doc.request.should be_a CXML::Request

        doc.response.should be_nil
        doc.message.should be_nil
      end

      it 'sets the correct document version' do
        doc.version.should be_a String
        doc.version.should eq '1.2.011'
      end

      it 'sets the correct document dtd' do
        doc.dtd.should be_a String
        doc.dtd.should eq 'cXML'
        described_class
          .new
          .from_xml(fixture('invoice_backed_and_unbacked_by_pos.xml'))
          .dtd.should eq 'InvoiceDetail'
      end
    end

    context 'when unknown attribute is present' do
      let(:data) { CXML::Parser.new(data: fixture('document_node_with_unknown_attribute.xml')).parse }
      let(:doc) { CXML::Document.new(data) }

      it 'does not raise and parses child nodes if CXML.raise_unknown_elements is false' do
        CXML.raise_unknown_elements = false
        -> { doc }.should_not raise_error

        doc.response.status.code.should eq(200)
        doc.response.status.content.should eq('123456')

        # Reset `raise_unknown_elements` for future tests
        CXML.raise_unknown_elements = true
      end

      it 'raises UnknownAttributeError' do
        -> { doc }.should raise_error(CXML::UnknownAttributeError)
      end
    end

    context 'when a response document is passed' do
      let(:data) { CXML::Parser.new(data: fixture('response_status_200.xml')).parse }
      include_examples :document_has_mandatory_values
      include_examples :document_has_a_timestamp

      it 'sets the correct document node attributes' do
        doc.response.should be_a CXML::Response

        doc.header.should be_nil
        doc.request.should be_nil
        doc.message.should be_nil
      end
    end

    context 'when a punch out order message is passed' do
      let(:data) { CXML::Parser.new(data: fixture('punch_out_order_message_doc.xml')).parse }
      include_examples :document_has_mandatory_values
      include_examples :document_has_a_header
      include_examples :document_has_a_timestamp

      it 'sets the correct document node attributes' do
        doc.header.should be_a CXML::Header
        doc.message.punch_out_order_message.should be_a CXML::PunchOutOrderMessage

        doc.request.should be_nil
        doc.response.should be_nil
      end
    end
  end

  describe '#to_xml' do
    let(:doc) { CXML::Document.new(data) }
    let(:output_xml) { doc.to_xml }
    let(:output_data) { CXML::Parser.new(data: output_xml).parse }

    it { should respond_to :to_xml }

    context 'when a request document is rendered' do
      let(:data) { CXML::Parser.new(data: fixture('request_doc.xml')).parse }
      include_examples :document_render_defaults
    end

    context 'when a valid response is rendered' do
      let(:data) { CXML::Parser.new(data: fixture('response_status_200.xml')).parse }
      it 'returns xml content' do
        output_xml.should_not be_nil
      end

      it 'validates against the DTD' do
        next unless test_for_xmllint

        lint_doc_with_dtd(CXML::Document.new.from_xml(output_xml)).should be true
      end

      it 'outputs the response with a valid status code' do
        output_data[:response].should_not be_empty
        output_data[:response][:status][:code].should eq('200')
        output_data[:response][:status].should eq(data[:response][:status])
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
        output_data[:response][:status][:code].should eq('400')
      end

      it 'validates against the DTD' do
        next unless test_for_xmllint

        lint_doc_with_dtd(CXML::Document.new.from_xml(output_xml)).should be true
      end
    end

    context 'when a punch out order message document is rendered' do
      let(:data) { CXML::Parser.new(data: fixture('punch_out_order_message_doc.xml')).parse }
      include_examples :document_render_defaults

      it 'outputs the punch out order message xml' do
        output_data[:message].should_not be_empty
        output_data[:message][:punch_out_order_message].should_not be_empty
      end

      it 'validates against the DTD' do
        next unless test_for_xmllint

        lint_doc_with_dtd(CXML::Document.new.from_xml(output_xml)).should be true
      end
    end
  end
end
