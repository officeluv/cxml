# frozen_string_literal: true

require 'spec_helper'

describe CXML::ItemIn do
  it { should respond_to :item_id? }
  it { should respond_to :item_detail? }
  it { should respond_to :quantity }

  let(:parser) { CXML::Parser.new }
  let(:data) { parser.parse(fixture('punch_out_order_message_doc.xml')) }
  let(:doc) { CXML::Document.new(data) }
  let(:punch_out_order_message) { doc.punch_out_order_message }
  let(:builder) { doc.render }

  describe '#initialize' do
    let(:item_in) { CXML::ItemIn.new(build_item_in(parser)) }

    it 'sets the mandatory attributes' do
      item_in.quantity.should_not be_nil
    end
  end

  describe '#render' do
    before(:each) do
      punch_out_order_message.add_item(build_item_in(parser))
    end

    let(:output_xml) { builder.to_xml }
    let(:output_data) { parser.parse(output_xml) }
    let(:punch_out_order_message_output_data) { output_data['Message']['PunchOutOrderMessage'] }
    let(:item_in_output_data) { punch_out_order_message_output_data['ItemIn'] }

    it 'contains the required nodes' do
      item_in_output_data['quantity'].should_not be_empty
      item_in_output_data['ItemID'].should_not be_empty
      item_in_output_data['ItemDetail'].should_not be_empty
    end
  end
end
