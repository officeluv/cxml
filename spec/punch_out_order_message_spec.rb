require 'spec_helper'

describe CXML::PunchOutOrderMessage do

  it { should respond_to :add_item }
  it { should respond_to :buyer_cookie }
  it { should respond_to :items_in }
  it { should respond_to :punch_out_order_message_header? }
  it { should respond_to :render }

  let(:parser) { CXML::Parser.new }
  let(:data) { parser.parse(fixture('punch_out_order_message_doc.xml')) }
  let(:doc) { CXML::Document.new(data) }
  let(:punch_out_order_message){doc.punch_out_order_message}
  let(:builder) {doc.render}

  describe "#add_item" do
    it "adds items to the order" do
      punch_out_order_message.add_item(build_item_in)
      punch_out_order_message.items_in.count.should == 1
    end
  end

  describe '#render' do
    let(:output_xml) {builder.to_xml}
    let(:output_data) {parser.parse(output_xml)}
    let(:punch_out_order_message_output_data) { output_data['Message']['PunchOutOrderMessage'] }

    it "returns xml content" do
      output_xml.should_not be_nil
    end

    it 'returns xml content with with required xml nodes' do
      punch_out_order_message_output_data["PunchOutOrderMessageHeader"].should_not be_empty
    end

  end

  def build_item_in
    # TODO - Use fixture data here ....
    {'Quantity' => '1',
     'ItemDetail' => {'Description' => 'Test Product', 'UnitOfMeasure' => 'EA', 'UnitPrice' => 788.78 },
     'ItemID' => {'SupplierPartID' => 'PartCode', 'SupplierPartAuxillaryID' => 'StockCode' }}
  end

end
