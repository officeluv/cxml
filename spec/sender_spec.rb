# frozen_string_literal: true

require 'spec_helper'

describe CXML::Sender do
  it { should respond_to :credential }
  it { should respond_to :user_agent }

  let(:parser) { CXML::Parser.new }
  let(:data) { parser.parse(fixture('punch_out_order_message_doc.xml')) }
  let(:doc) { CXML::Document.new(data) }
  let(:sender) { doc.header.sender }
  let(:builder) { doc.render }

  describe '#initialize' do
    it 'sets the mandatory attributes' do
      sender.credential.should_not be_nil
      sender.user_agent.should_not be_nil
    end
  end

  describe '#render' do
    let(:output_xml) { builder.to_xml }
    let(:output_data) { parser.parse(output_xml) }
    let(:sender_output_data) { output_data[:header][:sender] }

    it 'contains the required nodes' do
      sender_output_data[:user_agent].should_not be_empty
      sender_output_data[:credential].should_not be_empty
    end
  end
end
