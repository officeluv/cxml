# frozen_string_literal: true

require 'spec_helper'

describe CXML::PunchOutOrderMessageHeader do
  it { should respond_to :total }
  it { should respond_to :operation_allowed }

  let(:data) { CXML::Parser.new(data: fixture('punch_out_order_message_doc.xml')).parse }
  let(:doc) { CXML::Document.new(data) }
  let(:punch_out_order_message_header) { doc.message.punch_out_order_message.punch_out_order_message_header }

  describe '#initialize' do
    it 'sets the mandatory attributes' do
      punch_out_order_message_header.total.money.should be_instance_of(CXML::Money)
    end
  end

  describe '#render' do
    let(:output_xml) { doc.to_xml }
    let(:output_data) { CXML::Parser.new(data: output_xml).parse }
    let(:punch_out_order_message_output_data) { output_data[:message][:punch_out_order_message] }
    let(:punch_out_order_message_header_output_data) do
      punch_out_order_message_output_data[:punch_out_order_message_header]
    end

    it 'contains the required nodes' do
      punch_out_order_message_header_output_data[:operation_allowed].should_not be_empty
      punch_out_order_message_header_output_data[:total].should_not be_empty
      punch_out_order_message_header_output_data[:total][:money].should_not be_empty
    end
  end
end
