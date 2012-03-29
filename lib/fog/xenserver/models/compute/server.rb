require 'fog/compute/models/server'

module Fog
  module Compute
    class XenServer

      class Server < Fog::Compute::Server
        # API Reference here:
        # http://docs.vmd.citrix.com/XenServer/5.6.0/1.0/en_gb/api/?c=VM
        
        identity :reference
        
        attribute :uuid
        attribute :name,               :aliases => :name_label
        attribute :affinity
        attribute :allowed_operations
        attribute :consoles
        attribute :domarch
        attribute :domid
        attribute :guest_metrics
        attribute :is_a_snapshot
        attribute :is_a_template
        attribute :is_control_domain
        attribute :memory_dynamic_max
        attribute :memory_dynamic_min
        attribute :memory_static_max
        attribute :memory_static_min
        attribute :memory_target
        attribute :metrics
        attribute :name_description
        attribute :other_config
        attribute :power_state
        attribute :pv_args,            :aliases => :PV_args
        attribute :resident_on
        # Virtual Block Devices
        attribute :__vbds,               :aliases => :VBDs
        # Virtual CPUs
        attribute :vcpus_at_startup,   :aliases => :VCPUs_at_startup
        attribute :vcpus_max,          :aliases => :VCPUs_max
        # Virtual Interfaces (NIC)
        attribute :__vifs,               :aliases => :VIFs
        attribute :template_name

        #ignore_attributes :HVM_boot_params, :HVM_boot_policy, :HVM_shadow_multiplier, :PCI_bus, :PV_bootloader,
        #                  :PV_bootloader_args, :PV_kernel, :PV_legacy_args, :PV_ramdisk, :VCPUs_params, :VTPMs,
        #                  :actions_after_crash, :actions_after_reboot, :actions_after_shutdown, :blobs,
        #                  :blocked_operations, :crash_dumps, :current_operations, :ha_always_run, :ha_restart_priority,
        #                  :last_boot_CPU_flags, :last_booted_record, :platform, :recommendations, :snapshot_time,
        #                  :snapshots, :snapshot_of, :suspend_VDI, :tags, :transportable_snapshot_id, :user_version,
        #                  :xenstore_data, :memory_overhead, :children, :bios_strings, :parent, :snapshot_metadata,
        #                  :snapshot_info

        def initialize(attributes={})
          @connection = attributes[:connection]
          @uuid ||= 0
          super
        end

        def vbds
          __vbds.collect {|vbd| Fog::Compute::XenServer::VBD.new(connection.get_vbd_by_ref( vbd ))}
          #__vbds.collect {|vbd| connection.get_vbd_by_ref( vbd ) }
        end

        def hard_shutdown
          connection.hard_shutdown_server( reference )
          wait_for { !running? }
          true
        end
        
        def destroy
          raise "VM still running. Power it off first." if running?
          __vbds.each do |vbd|
            connection.destroy_vbd( vbd )
          end
          connection.destroy_server( reference )
          true
        end
        
        def refresh
          requires :reference
          data = connection.get_vm_by_ref( reference )
          merge_attributes( data )
        end

        def vifs
          networks
        end

        # associations
        def networks
          __vifs.collect {|vif| Fog::Compute::XenServer::VIF.new(connection.get_vif_by_ref( vif ))}
        end
        
        def running_on
          Fog::Compute::XenServer::Host.new(connection.get_host_by_ref( resident_on ))
        end
        
        def home_hypervisor
          connection.hosts.first
        end
        
        def mac_address
          networks.first.MAC
        end
        
        def running?
          power_state =~ /Running/
        end
        
        def halted?
          power_state =~ /Halted/
        end
        
        # operations
        def start
          return false if halted?
          connection.start_server( reference )
          true
        end

        def save(params = {})
          requires :name
          new_vm = connection.create_server( name, template_name, nil) 
          merge_attributes(new_vm.attributes)
          true
        end

        # def reboot(type = 'SOFT')
        #   requires :reference
        #   connection.reboot_server(@id, type)
        #   true
        # end
        
        # def snapshot
        #   requires :reference, :name_label
        #   data = connection.snapshot_server(@reference, @name_label)
        #   merge_attributes(data.body)
        #   true
        # end
      end

    end
  end
end
