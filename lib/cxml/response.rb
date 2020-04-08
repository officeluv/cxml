# frozen_string_literal: true

# Servers send responses to inform clients of the results of operations. Because the
# result of some requests might not have any data, the Response element can optionally
# contain nothing but a Status element. A Response element can also contain any
# application-level data. During PunchOut for example, the application-level data is
# contained in a PunchOutSetupResponse element.

module CXML
  class Response < DocumentNode
    accessible_attributes %i[
      deployment_mode
      id
    ]
    accessible_nodes %i[
      status
      punch_out_setup_response
    ]
  end
end
