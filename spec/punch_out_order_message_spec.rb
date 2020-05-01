# frozen_string_literal: true

require 'spec_helper'

describe CXML::PunchOutOrderMessage do
  it { should respond_to :add_item }
  it { should respond_to :buyer_cookie }
  it { should respond_to :items_in }

  let(:data) { CXML::Parser.new(data: fixture('punch_out_order_message_doc.xml')).parse }
  let(:doc) { CXML::Document.new(data) }
  let(:punch_out_order_message) { doc.message.punch_out_order_message }

  describe '#initialize' do
    it 'sets the mandatory attributes' do
      punch_out_order_message.punch_out_order_message_header
                             .should be_an_instance_of CXML::PunchOutOrderMessageHeader
    end
  end

  describe '#add_item' do
    it 'adds items to the order' do
      punch_out_order_message.add_item(build_item_in)
      punch_out_order_message.items_in.count.should == 1
    end
  end

  describe '#render' do
    let(:output_xml) { doc.to_xml }
    let(:output_data) { CXML::Parser.new(data: output_xml).parse }
    let(:punch_out_order_message_output_data) { output_data[:message][:punch_out_order_message] }

    it 'contains the required nodes' do
      punch_out_order_message.add_item(build_item_in)
      punch_out_order_message_output_data[:punch_out_order_message_header].should_not be_empty
      punch_out_order_message_output_data[:buyer_cookie].should_not be_empty
      punch_out_order_message_output_data.should include(:item_in)
    end
    it 'validates against the DTD' do
      next unless test_for_xmllint

      lint_doc_with_dtd(CXML::Document.new.from_xml(output_xml)).should be true
    end
  end
end
