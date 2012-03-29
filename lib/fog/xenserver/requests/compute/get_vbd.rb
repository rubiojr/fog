module Fog
  module Compute
    class XenServer

      class Real
        
        require 'fog/xenserver/parser'
        
        def get_vbd_by_ref( ref, options = {} )
          @connection.request({:parser => Fog::Parsers::XenServer::Base.new, :method => 'VBD.get_record'}, ref).merge(:reference => ref)
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
