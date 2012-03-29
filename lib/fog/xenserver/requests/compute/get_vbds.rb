module Fog
  module Compute
    class XenServer

      class Real
        
        require 'fog/xenserver/parsers/get_vbds'
        
        def get_vbds( options = {} )
          @connection.request(:parser => Fog::Parsers::XenServer::GetVBDs.new, :method => 'VBD.get_all_records')
        end

      end
      
      class Mock
        
        def get_vbds
          Fog::Mock.not_implemented
        end
        
      end

    end
  end
end
