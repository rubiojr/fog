require 'fog/core/collection'
require 'fog/xenserver/models/compute/host'

module Fog
  module Compute
    class XenServer
      
      class Hosts < Fog::Collection
        
        model Fog::Compute::XenServer::Host
        
        def all
          data = connection.get_hosts
          load(data)
        end
        
        def get( host_ref )
          if host_ref && host = connection.get_host_by_ref( host_ref )
            new(host)
          end
        rescue Fog::Xenserver::NotFound
          nil
        end
        
      end
      
    end
  end
end
