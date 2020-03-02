# frozen_string_literal: true

module CXML
  class Sender
    attr_accessor :credential
    attr_accessor :user_agent

    def initialize(data = {})
      return unless data.is_a?(Hash) && !data.empty?

      @credential = CXML::Credential.new(data['Credential'] || data['credential'])
      @user_agent = data['UserAgent'] || data['user_agent']
    end

    def render(node)
      node.Sender do |n|
        n.UserAgent(@user_agent)
        @credential.render(n)
      end
      node
    end
  end
end
