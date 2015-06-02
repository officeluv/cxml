require 'spec_helper'

describe CXML::PunchOutSetupRequest do

  it { should respond_to :browser_form_post_url }
  it { should respond_to :supplier_setup_url }


  let(:parser) { CXML::Parser.new }
  let(:data) { parser.parse(fixture('punch_out_setup_request_doc.xml')) }
  let(:doc) { CXML::Document.new(data) }
  let(:request) { doc.request }
  let(:punch_out_setup_request) { request.punch_out_setup_request }


  describe '#initialize' do
    it "sets the mandatory attributes" do
      punch_out_setup_request.browser_form_post_url.should_not be_nil
      punch_out_setup_request.supplier_setup_url.should_not be_nil
    end
  end

end
