# cXML

![Ruby Specs](https://github.com/officeluv/cxml/workflows/Ruby%20Specs/badge.svg)

Ruby implementation of the cXML protocol. 

Currently supports:

- Request
  - InvoiceDetailRequest
  - OrderRequest
  - PunchOutSetupRequest
  - ConfirmationRequest
- Response
  - Status
  - PunchOutSetupResponse
- Message
  - PunchOutOrderMessage
- Pull requests welcome to support more!

## Usage

```rb
some_xml = '....'
doc = CXML::Document.new.from_xml(some_xml)
# raises CXML::UnknownAttributeError if unknown fields are present

doc.response.status.code
# => 200
doc.response.status.success?
# => true

CXML::Document.new(response: { status: { code: '200' } }).render.to_xml
# => '<?xml.....'
```

## Configuration

```rb
CXML.configure do |config|
  # Set this to false to log intead of raise exception on unknown elements
  # defaults to true, raises CXML::UnknownAttributeError
  config.raise_unknown_elements = true

  # Optionally set a custom logger, used for parsing error logging
  # defaults to Logger.new(STDOUT, level: :warn)
  config.logger = Logger.new(STDOUT, level: :warn)
end
```

## Running Tests

Install dependencies:

```
bundle install
```

Run suite:

```
rspec
```

## Documentation

Procotol specifications could be found here [http://xml.cxml.org/current/cXMLUsersGuide.pdf](http://xml.cxml.org/current/cXMLUsersGuide.pdf)
