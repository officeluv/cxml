# frozen_string_literal: true

require 'spec_helper'

describe CXML::Credential do
  it { should respond_to :domain }
  it { should respond_to :type }
  it { should respond_to :shared_secret }
  it { should respond_to :credential_mac }
  it { should respond_to :identity }

  let(:data) { CXML::Parser.new(data: fixture('punch_out_order_message_doc.xml')).parse }
  let(:doc) { CXML::Document.new(data) }
  let(:sender) { doc.header.sender }
  let(:credential) { sender.credential }

  describe '#initialize' do
    it 'sets the attributes that are passed' do
      credential.shared_secret.should_not be_nil
      credential.identity.should_not be_nil
    end
  end

  describe '#render' do
    let(:output_xml) { doc.to_xml }
    let(:output_data) { CXML::Parser.new(data: output_xml).parse }
    let(:sender_output_data) { output_data[:header][:sender] }
    let(:credential_output_data) { sender_output_data[:credential] }

    it 'contains the required nodes' do
      credential_output_data[:shared_secret].should_not be_empty
      credential_output_data[:identity].should_not be_empty
    end
  end
end
