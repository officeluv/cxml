# frozen_string_literal: true

require 'spec_helper'

describe CXML::InvoiceDetailRequest do
  it { should respond_to :invoice_detail_request_header }
  it { should respond_to :invoice_detail_orders }
  it { should respond_to :invoice_detail_header_orders }
  it { should respond_to :invoice_detail_summary }

  describe '#initialize' do
    it 'sets invoice_detail_request_header' do
      data = CXML::Parser.new.parse(fixture('invoice_taxes_at_line.xml'))
      doc = CXML::Document.new(data)
      instance = doc.request.invoice_detail_request
      instance.invoice_detail_request_header
              .should be_an_instance_of CXML::InvoiceDetailRequestHeader
    end
    it 'sets invoice_detail_request_header' do
      data = CXML::Parser.new.parse(fixture('invoice_taxes_at_total.xml'))
      doc = CXML::Document.new(data)
      instance = doc.request.invoice_detail_request
      instance.invoice_detail_request_header
              .should be_an_instance_of CXML::InvoiceDetailRequestHeader
    end
    it 'sets invoice_detail_request_header' do
      data = CXML::Parser.new.parse(fixture('invoice_taxes_at_line_multiple_taxes.xml'))
      doc = CXML::Document.new(data)
      instance = doc.request.invoice_detail_request
      instance.invoice_detail_request_header
              .should be_an_instance_of CXML::InvoiceDetailRequestHeader
    end
    it 'sets invoice_detail_request_header' do
      data = CXML::Parser.new.parse(fixture('invoice_backed_and_unbacked_by_pos.xml'))
      doc = CXML::Document.new(data)
      instance = doc.request.invoice_detail_request
      instance.invoice_detail_request_header
              .should be_an_instance_of CXML::InvoiceDetailRequestHeader
    end
    it 'sets invoice_detail_request_header' do
      data = CXML::Parser.new.parse(fixture('invoice_backed_by_multiple_pos.xml'))
      doc = CXML::Document.new(data)
      instance = doc.request.invoice_detail_request
      instance.invoice_detail_request_header
              .should be_an_instance_of CXML::InvoiceDetailRequestHeader
    end
  end
  describe '#to_xml' do
    it 'serializes the same output' do
      data = CXML::Parser.new.parse(fixture('invoice_taxes_at_line.xml'))
      doc = CXML::Document.new(data)
      CXML::Parser.new.parse(doc.render.to_xml).should eq(data)
    end
    it 'serializes the same output' do
      data = CXML::Parser.new.parse(fixture('invoice_backed_and_unbacked_by_pos.xml'))
      doc = CXML::Document.new(data)
      CXML::Parser.new.parse(doc.render.to_xml).should eq(data)
    end
    it 'serializes the same output' do
      data = CXML::Parser.new.parse(fixture('invoice_backed_by_multiple_pos.xml'))
      doc = CXML::Document.new(data)
      CXML::Parser.new.parse(doc.render.to_xml).should eq(data)
    end
    it 'serializes the same output' do
      data = CXML::Parser.new.parse(fixture('invoice_taxes_at_line_multiple_taxes.xml'))
      doc = CXML::Document.new(data)
      CXML::Parser.new.parse(doc.render.to_xml).should eq(data)
    end
    it 'serializes the same output' do
      fixture_xml = fixture('invoice_taxes_at_total.xml')
      data = CXML::Parser.new.parse(fixture_xml)
      doc = CXML::Document.new(data)
      CXML::Parser.new.parse(doc.render.to_xml).should eq(data)
    end
    it 'serializes from an instance' do
      money = CXML::Money.new(amount: '5', currency: 'USD')
      summary = CXML::InvoiceDetailSummary.new(gross_amount: CXML::GrossAmount.new(money: money))
      instance = described_class.new(invoice_detail_summary: summary)
      data = CXML::Request.new(invoice_detail_request: instance)
      doc = CXML::Document.new(request: data)
      parsed = CXML::Parser.new.parse(doc.render.to_xml)
      parsed[:request][:invoice_detail_request]
        .should eq(instance.serializable_hash)
      parsed[:request][:invoice_detail_request][:invoice_detail_summary][:gross_amount][:money]
        .should eq({ content: '5', currency: 'USD' })
    end
  end
end
