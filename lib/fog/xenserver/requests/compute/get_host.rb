module Fog
  module Compute
    class XenServer

      class Real

        require 'fog/xenserver/parser'

        def get_host( name_label )
          host_ref = @connection.request({:parser => Fog::Parsers::XenServer::Base.new, :method => 'host.get_by_name_label'}, name_label)
          get_host_by_ref( host_ref )
        end
        
        def get_host_by_ref( host_ref )
          @connection.request({:parser => Fog::Parsers::XenServer::Base.new, :method => 'host.get_record'}, host_ref).merge(:reference => host_ref)
        end
        
      end
      
      class Mock
        
        def get_host( uuid )
          Fog::Mock.not_implemented
        end
        
      end

    end
  end
end
