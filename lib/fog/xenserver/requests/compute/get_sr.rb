module Fog
  module XenServer
    class Real
      
      require 'fog/xenserver/parser'
      
      def get_sr( name_label )
        sr_ref = @connection.request({:parser => Fog::Parsers::XenServer::Base.new, :method => 'SR.get_by_name_label'}, name_label)
        get_sr_by_ref( sr_ref )
      end
      
      def get_sr_by_ref( sr_ref )
        @connection.request({:parser => Fog::Parsers::XenServer::Base.new, :method => 'SR.get_record'}, sr_ref).merge(:reference => sr_ref)
      end
    end
    
    class Mock
      
      def get_sr( uuid )
        Fog::Mock.not_implemented
      end

      def get_sr_by_ref( sr_ref )
        Fog::Mock.not_implemented
      end
      
    end
  end
end
