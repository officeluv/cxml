# frozen_string_literal: true

require 'spec_helper'

describe CXML::PunchOutOrderMessageHeader do
  it { should respond_to :money? }
  it { should respond_to :render }

  let(:parser) { CXML::Parser.new }
  let(:data) { parser.parse(fixture('punch_out_order_message_doc.xml')) }
  let(:doc) { CXML::Document.new(data) }
  let(:punch_out_order_message_header) { doc.punch_out_order_message.punch_out_order_message_header }
  let(:builder) { doc.render }

  describe '#initialize' do
    it 'sets the mandatory attributes' do
      punch_out_order_message_header.money.should be_instance_of(CXML::Money)
    end
  end

  describe '#render' do
    let(:output_xml) { builder.to_xml }
    let(:output_data) { parser.parse(output_xml) }
    let(:punch_out_order_message_output_data) { output_data['Message']['PunchOutOrderMessage'] }
    let(:punch_out_order_message_header_output_data) { punch_out_order_message_output_data['PunchOutOrderMessageHeader'] }

    it 'contains the required nodes' do
      punch_out_order_message_header_output_data['operationAllowed'].should_not be_empty
      punch_out_order_message_header_output_data['Total'].should_not be_empty
      punch_out_order_message_header_output_data['Total']['Money'].should_not be_empty
    end
  end
end
