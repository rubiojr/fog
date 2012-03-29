require 'fog/core/model'

module Fog
  module Compute
    class XenServer
    
      class VBD < Fog::Model
        # API Reference here:
        # http://docs.vmd.citrix.com/XenServer/5.6.0/1.0/en_gb/api/?c=VBD
        
        identity :reference
        
        attribute :uuid
        attribute :currently_attached
        attribute :reserved
        attribute :vdi, :aliases => :VDI
        attribute :vm, :aliases => :VM
        
        #ignore_attributes :current_operations, :qos_supported_algorithms, :qos_algorithm_params, :qos_algorithm_type, :other_config,
        #                  :runtime_properties
        
        def initialize(attributes={})
          @uuid ||= 0
          super
        end
      end
      
    end
  end
end
