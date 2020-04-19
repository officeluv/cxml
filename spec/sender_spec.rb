# frozen_string_literal: true

require 'spec_helper'

describe CXML::Sender do
  it { should respond_to :credential }
  it { should respond_to :user_agent }

  let(:data) { CXML::Parser.new(data: fixture('punch_out_order_message_doc.xml')).parse }
  let(:doc) { CXML::Document.new(data) }
  let(:sender) { doc.header.sender }

  describe '#initialize' do
    it 'sets the mandatory attributes' do
      sender.credential.should_not be_nil
      sender.user_agent.should_not be_nil
    end
  end

  describe '#render' do
    let(:output_xml) { doc.to_xml }
    let(:output_data) { CXML::Parser.new(data: output_xml).parse }
    let(:sender_output_data) { output_data[:header][:sender] }

    it 'contains the required nodes' do
      sender_output_data[:user_agent].should_not be_empty
      sender_output_data[:credential].should_not be_empty
    end
  end
end
