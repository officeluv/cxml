# frozen_string_literal: true

# Clients send requests for operations. Only one Request element is allowed for each
# cXML envelope element, which simplifies the server implementations, because no
# demultiplexing needs to occur when reading cXML documents. The Request element
# can contain virtually any type of XML data.

module CXML
  class Request < DocumentNode
    accessible_attributes %i[
      deployment_mode
      id
    ]
    accessible_nodes %i[
      confirmation_request
      invoice_detail_request
      order_request
      punch_out_setup_request
    ]
  end
end
