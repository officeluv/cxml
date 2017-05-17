require 'spec_helper'

describe CXML::Request do

  it { should respond_to :punch_out_setup_request }
  it { should respond_to :id }
  it { should respond_to :deployment_mode }


  let(:parser) { CXML::Parser.new }
  let(:data) { parser.parse(fixture('punch_out_setup_request_doc.xml')) }
  let(:doc) { CXML::Document.new(data) }
  let(:request) { doc.request }

  describe '#initialize' do
    it "sets the mandatory attributes" do
      request.deployment_mode.should_not be_nil
      request.punch_out_setup_request.should be_an_instance_of CXML::PunchOutSetupRequest
    end
  end

end
