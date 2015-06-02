require 'spec_helper'

describe CXML::Credential do

  it { should respond_to :domain }
  it { should respond_to :type }
  it { should respond_to :shared_secret }
  it { should respond_to :credential_mac }
  it { should respond_to :identity }

  let(:parser) { CXML::Parser.new }
  let(:data) { parser.parse(fixture('punch_out_order_message_doc.xml')) }
  let(:doc) { CXML::Document.new(data) }
  let(:sender){doc.header.sender}
  let(:credential){sender.credential}
  let(:builder) {doc.render}

  describe '#initialize' do
    it "sets the attributes that are passed" do
      credential.shared_secret.should_not be_nil
      credential.identity.should_not be_nil
    end
  end

  describe '#render' do
    let(:output_xml) {builder.to_xml}
    let(:output_data) {parser.parse(output_xml)}
    let(:sender_output_data) { output_data['Header']['Sender'] }
    let(:credential_output_data) { sender_output_data['Credential'] }

    it 'contains the required nodes' do
      credential_output_data['SharedSecret'].should_not be_empty
      credential_output_data['Identity'].should_not be_empty
    end
  end

end
