# frozen_string_literal: true

require 'spec_helper'

describe CXML::ItemIn do
  it { should respond_to :item_id }
  it { should respond_to :item_detail }
  it { should respond_to :line_number }
  it { should respond_to :quantity }

  let(:data) { CXML::Parser.new(data: fixture('punch_out_order_message_doc.xml')).parse }
  let(:doc) { CXML::Document.new(data) }
  let(:punch_out_order_message) { doc.message.punch_out_order_message }

  describe '#initialize' do
    let(:item_in) { CXML::ItemIn.new(build_item_in) }

    it 'sets the mandatory attributes' do
      item_in.quantity.should_not be_nil
    end
  end

  describe '#render' do
    before(:each) do
      punch_out_order_message.add_item(build_item_in)
    end

    let(:output_xml) { doc.to_xml }
    let(:output_data) { CXML::Parser.new(data: output_xml).parse }
    let(:punch_out_order_message_output_data) { output_data[:message][:punch_out_order_message] }
    let(:item_in_output_data) { punch_out_order_message_output_data[:item_in] }

    it 'contains the required nodes' do
      item_in_output_data[:quantity].should_not be_empty
      item_in_output_data[:item_id].should_not be_empty
      item_in_output_data[:item_detail].should_not be_empty
    end
  end
end
