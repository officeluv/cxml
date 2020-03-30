# frozen_string_literal: true

require 'spec_helper'

describe CXML::PunchOutOrderMessage do
  it { should respond_to :add_item }
  it { should respond_to :buyer_cookie }
  it { should respond_to :items_in }
  it { should respond_to :render }

  let(:parser) { CXML::Parser.new }
  let(:data) { parser.parse(fixture('punch_out_order_message_doc.xml')) }
  let(:doc) { CXML::Document.new(data) }
  let(:punch_out_order_message) { doc.punch_out_order_message }
  let(:builder) { doc.render }

  describe '#initialize' do
    it 'sets the mandatory attributes' do
      punch_out_order_message.punch_out_order_message_header.should be_an_instance_of CXML::PunchOutOrderMessageHeader
    end
  end

  describe '#add_item' do
    it 'adds items to the order' do
      punch_out_order_message.add_item(build_item_in(parser))
      punch_out_order_message.items_in.count.should == 1
    end
  end

  describe '#render' do
    let(:output_xml) { builder.to_xml }
    let(:output_data) { parser.parse(output_xml) }
    let(:punch_out_order_message_output_data) { output_data['Message']['PunchOutOrderMessage'] }

    it 'contains the required nodes' do
      punch_out_order_message.add_item(build_item_in(parser))
      punch_out_order_message_output_data['PunchOutOrderMessageHeader'].should_not be_empty
      punch_out_order_message_output_data['BuyerCookie'].should_not be_empty
      punch_out_order_message_output_data.should include('ItemIn')
    end
  end
end
