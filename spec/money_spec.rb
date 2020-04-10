# frozen_string_literal: true

require 'spec_helper'

describe CXML::Money do
  it { should respond_to :currency }
  it { should respond_to :alternate_currency }
  it { should respond_to :alternate_amount }
  it { should respond_to :amount }

  let(:parser) { CXML::Parser.new }
  let(:data) { parser.parse(fixture('punch_out_order_message_doc.xml')) }
  let(:doc) { CXML::Document.new(data) }
  let(:punch_out_order_message) { doc.message.punch_out_order_message }
  let(:builder) { doc.render }
  let(:item_in) { CXML::ItemIn.new(build_item_in(parser)) }
  let(:item_detail) { item_in.item_detail }
  let(:money) { item_detail.unit_price.money }

  describe '#initialize' do
    it 'sets the attributes that are passed' do
      money.currency.should_not be_nil
      money.amount.should_not be_nil
    end
  end

  describe '#render' do
    before(:each) do
      punch_out_order_message.add_item(build_item_in(parser))
    end

    let(:output_xml) { builder.to_xml }
    let(:output_data) { parser.parse(output_xml) }
    let(:punch_out_order_message_output_data) { output_data[:message][:punch_out_order_message] }
    let(:item_in_output_data) { punch_out_order_message_output_data[:item_in] }
    let(:item_detail_output_data) { item_in_output_data[:item_detail] }
    let(:unit_price_output_data) { item_detail_output_data[:unit_price] }
    let(:money_output_data) { unit_price_output_data[:money] }

    it 'contains the required nodes' do
      money_output_data[:currency].should_not be_empty
    end
  end
end
