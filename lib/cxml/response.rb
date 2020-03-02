# frozen_string_literal: true

# Servers send responses to inform clients of the results of operations. Because the
# result of some requests might not have any data, the Response element can optionally
# contain nothing but a Status element. A Response element can also contain any
# application-level data. During PunchOut for example, the application-level data is
# contained in a PunchOutSetupResponse element.

module CXML
  class Response
    attr_accessor :id
    attr_accessor :status
    attr_accessor :punch_out_setup_response
    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @status = CXML::Status.new(data['Status'] || data['status'])
      @punch_out_setup_response = CXML::PunchOutSetupResponse.new(data['PunchOutSetupResponse'] || data['punch_out_setup_response'])
    end

    def render(node)
      options = { id: @id }
      options.delete_if { |_k, v| v.nil? }
      node.Response(options) do |n|
        @status.render(n)
        node.PunchOutSetupResponse { |nn| punch_out_setup_response.render(nn) } if status.success?
      end
    end
  end
end
