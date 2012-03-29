module Fog
  module Compute
    class  XenServer

      class Real
        
        def hard_shutdown_server( vm_ref )
          @connection.request({:parser => Fog::Parsers::XenServer::Base.new, :method => 'VM.hard_shutdown'}, vm_ref)
        end
        
      end
      
      class Mock
        
        def hard_shutdown_server( vm_ref )
          Fog::Mock.not_implemented
        end
        
      end

    end
  end
end
