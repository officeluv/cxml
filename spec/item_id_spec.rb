# frozen_string_literal: true

require 'spec_helper'

describe CXML::ItemID do
  it { should respond_to :supplier_part_id }
  it { should respond_to :supplier_part_auxiliary_id }

  let(:data) { CXML::Parser.new(data: fixture('punch_out_order_message_doc.xml')).parse }
  let(:doc) { CXML::Document.new(data) }
  let(:punch_out_order_message) { doc.message.punch_out_order_message }

  describe '#initialize' do
    let(:item_in) { CXML::ItemIn.new(build_item_in) }
    let(:item_id) { item_in.item_id }

    it 'sets the attributes that are passed' do
      item_id.supplier_part_id.should_not be_nil
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
    let(:item_id_output_data) { item_in_output_data[:item_id] }

    it 'contains the required nodes' do
      item_id_output_data[:supplier_part_id].should_not be_empty
      item_id_output_data.should include(:supplier_part_auxiliary_id)
    end
  end
end
