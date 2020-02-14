require 'spec_helper'

describe CXML::PunchOutSetupRequest do

  it { should respond_to :browser_form_post_url }
  it { should respond_to :supplier_setup_url }


  let(:parser) { CXML::Parser.new }
  let(:data) { parser.parse(fixture('punch_out_setup_request_doc.xml')) }
  let(:data_coupa) { parser.parse(fixture('punch_out_setup_request_doc_coupa.xml')) }
  let(:doc) { CXML::Document.new(data) }
  let(:doc_coupa) { CXML::Document.new(data_coupa) }
  let(:request) { doc.request }
  let(:request_coupa) { doc_coupa.request }
  let(:punch_out_setup_request) { request.punch_out_setup_request }
  let(:punch_out_setup_request_coupa) { request_coupa.punch_out_setup_request }


  describe '#initialize' do
    it "sets the mandatory attributes" do
      punch_out_setup_request.browser_form_post_url.should_not be_nil
      punch_out_setup_request.supplier_setup_url.should_not be_nil
    end
    it "sets the mandatory coupa attributes" do
      punch_out_setup_request_coupa.browser_form_post_url.should_not be_nil
      punch_out_setup_request_coupa.buyer_cookie.should_not be_nil
      punch_out_setup_request_coupa.contact.email.should_not be_nil
      punch_out_setup_request_coupa.extrinsics.should be_a Array
      punch_out_setup_request_coupa.extrinsics.first.should be_a CXML::Extrinsic
      punch_out_setup_request_coupa.extrinsics.first.name.should_not be_nil
    end
  end
end
