require 'fog/core/collection'
require 'fog/xenserver/models/compute/server'

module Fog
  module Compute
    class XenServer

      class Servers < Fog::Collection

        model Fog::Compute::XenServer::Server

        def all
          data = connection.get_vms
          data.delete_if {|vm| vm[:is_a_template]}
          data.delete_if {|vm| vm[:is_control_domain]}
          data.delete_if {|vm| vm[:is_snapshot]}
          load(data)
        end

        def get( vm_ref )
          if vm_ref && vm = connection.get_vm_by_ref( vm_ref )
            new(vm)
          end
        rescue Fog::XenServer::NotFound
          nil
        end

      end

    end
  end
end
