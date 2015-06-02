require 'spec_helper'

describe CXML::Money do

  it { should respond_to :currency }
  it { should respond_to :alternate_currency }
  it { should respond_to :alternate_amount }
  it { should respond_to :amount }
  it { should respond_to :build_attributes }

  let(:parser) { CXML::Parser.new }
  let(:data) { parser.parse(fixture('punch_out_order_message_doc.xml')) }
  let(:doc) { CXML::Document.new(data) }
  let(:punch_out_order_message){doc.punch_out_order_message}
  let(:builder) {doc.render}
  let(:item_in) { CXML::ItemIn.new(build_item_in(parser))}
  let(:item_detail) { item_in.item_detail}
  let(:money) {item_detail.unit_price}

  describe '#initialize' do
    it "sets the attributes that are passed" do
      money.currency.should_not be_nil
      money.amount.should_not be_nil
    end
  end

  describe "#build_attributes" do

    it "returns a hash" do
      money.build_attributes.should be_an_instance_of Hash
    end

    it "the hash contains the default attributes" do
      money.build_attributes.should include('currency')
    end

  end

  describe '#render' do
    before(:each) do
      punch_out_order_message.add_item(build_item_in(parser))
    end

    let(:output_xml) {builder.to_xml}
    let(:output_data) {parser.parse(output_xml)}
    let(:punch_out_order_message_output_data) { output_data['Message']['PunchOutOrderMessage'] }
    let(:item_in_output_data) {punch_out_order_message_output_data['ItemIn'] }
    let(:item_detail_output_data) {item_in_output_data['ItemDetail'] }
    let(:unit_price_output_data) {item_detail_output_data['UnitPrice'] }
    let(:money_output_data) {unit_price_output_data['Money'] }

    it 'contains the required nodes' do
      money_output_data['currency'].should_not be_empty
    end

  end


end
