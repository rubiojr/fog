module Fog
  module Compute
    class Brightbox
      class Real
        # Update some details of the API client.
        #
        # @param [String] identifier Unique reference to identify the resource
        # @param [Hash] options
        # @option options [String] :name
        # @option options [String] :description
        #
        # @return [Hash, nil] The JSON response parsed to a Hash or nil if no options passed
        #
        # @see https://api.gb1.brightbox.com/1.0/#api_client_update_api_client
        #
        def update_api_client(identifier, options)
          return nil if identifier.nil? || identifier == ""
          return nil if options.empty? || options.nil?
          request("put", "/1.0/api_clients/#{identifier}", [200], options)
        end

      end
    end
  end
end