# frozen_string_literal: true

require 'spec_helper'

describe CXML::OrderRequest do
  it { should respond_to :order_request_header }
  it { should respond_to :items_out }

  let(:data) { CXML::Parser.new(data: fixture('purchase_order_request_200.xml')).parse }
  let(:doc) { CXML::Document.new(data) }
  let(:order_request) { doc.request.order_request }
  let(:output_xml) { doc.to_xml }
  let(:output_data) { CXML::Parser.new(data: output_xml).parse }
  let(:order_request_output_data) { output_data[:request][:order_request] }

  describe '#to_xml' do
    it 'contains the required nodes' do
      order_request_output_data[:order_request_header].should_not be_empty
      order_request_output_data[:item_out].should be_a Array
      order_request_output_data[:item_out].length.should eq 2
    end
  end
  describe '#initialize' do
    it 'sets the required nodes' do
      order_request.order_request_header.should_not be_nil
      order_request.order_request_header.order_id.should_not be_nil
      order_request.items_out.first.should_not be_nil
    end
    it 'sets the required nodes via another  order request' do
      request = CXML::Document.new.from_xml(fixture('order_request.cxml')).request
      request.order_request.order_request_header.should_not be_nil
      request.order_request.order_request_header.order_id.should_not be_nil
      request.order_request.items_out.first.should_not be_nil
      request.order_request.items_out.first.item_detail.extrinsics.first.should_not be_nil
    end
  end
end
