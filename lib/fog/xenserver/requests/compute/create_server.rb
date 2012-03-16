module Fog
  module XenServer
    class Real

      def create_server( name_label, image = nil, network = nil )
        create_vm( name_label, image, network )
      end

    end

    class Mock

      def create_server()
        Fog::Mock.not_implemented
      end

    end
  end
end
