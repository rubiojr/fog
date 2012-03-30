require 'fog/core/collection'
require 'fog/xenserver/models/compute/vbd'

module Fog
  module Compute
    class XenServer

      class Vbds < Fog::Collection

        model Fog::Compute::XenServer::VBD

        def all(options = {})
          data = connection.get_records 'VBD'
          #data.delete_if { |vm| vm[:is_a_template] and !options[:include_templates] }
          load(data)
        end

        def get( vbd_ref )
          if vbd_ref && vbd = connection.get_record( vbd_ref, 'VBD' )
            new(vbd)
          end
        rescue Fog::XenServer::NotFound
          nil
        end

      end

    end
  end
end
