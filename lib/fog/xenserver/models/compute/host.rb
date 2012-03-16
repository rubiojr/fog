require 'fog/compute/models/server'

module Fog
  module Compute
    class XenServer

      class Host < Fog::Compute::Server
        # API Reference here:
        # http://docs.vmd.citrix.com/XenServer/5.6.0/1.0/en_gb/api/?c=host
        
        identity :reference
        
        attribute :name,              :aliases => :name_label
        attribute :uuid
        attribute :address
        attribute :allowed_operations
        attribute :enabled
        attribute :hostname
        attribute :metrics
        attribute :name_description
        attribute :other_config
        attribute :phy_block_devices, :aliases => :PBDs
        attribute :phy_interfaces,    :aliases => :PIFs
        attribute :resident_vms,      :aliases => :resident_VMs
        
        #ignore_attributes :API_version_major, :API_version_minor, :API_version_vendor, :API_version_vendor_implementation,
        #                  :blobs, :capabilities, :cpu_configuration, :crash_dump_sr, :crashdumps, :current_operations,
        #                  :external_auth_configuration, :external_auth_service_name, :external_auth_type,
        #                  :ha_network_peers, :ha_statefiles, :host_CPUs, :license_params, :logging, :patches,
        #                  :sched_policy, :software_version, :supported_bootloaders, :suspend_image_sr, :tags
        
        def initialize(attributes={})
          @uuid ||= 0
          super
        end
        
      end
      
    end
  end
end
