require File.expand_path(File.join(File.dirname(__FILE__), '..', 'xenserver'))
require 'fog/compute'

module Fog
  module Compute 
    class XenServer < Fog::Service

      require 'fog/xenserver/utilities'
      require 'fog/xenserver/parser'
      
      requires :xenserver_username
      requires :xenserver_password
      requires :xenserver_url
      recognizes :xenserver_defaults
      
      model_path 'fog/xenserver/models/compute'
      model :server
      collection :servers
      model :host
      collection :hosts
      model :vif
      collection :storage_repositories
      model :storage_repository
      collection :pools
      model :pool
      model :vbd
      
      request_path 'fog/xenserver/requests/compute'
      request :create_server
      request :create_vif
      request :create_vm
      request :destroy_server
      request :destroy_vbd
      request :hard_shutdown_server
      request :get_host
      request :get_hosts
      request :get_network
      request :get_networks
      request :get_storage_repository
      request :get_storage_repositories
      request :get_vif
      request :get_vifs
      request :get_vm
      request :get_vms
      request :start_vm
      request :get_pool
      request :get_pools
      request :get_vbds
      request :get_vbd
      request :set_affinity
    
      class Real
        
        def initialize(options={})
          @host        = options[:xenserver_url]
          @username    = options[:xenserver_username]
          @password    = options[:xenserver_password]
          @defaults    = options[:xenserver_defaults] || {}
          @connection  = Fog::XenServer::Connection.new(@host)
          @connection.authenticate(@username, @password)
        end

        def reload
          @connection.authenticate(@username, @password)
        end
        
        def default_template
          return nil if @defaults[:template].nil?
          data = get_vm( @defaults[:template] )
          return nil if data[:reference].nil?
          Fog::Compute::XenServer::Server.new(data)
        end
        
        def default_network
          Fog::XenServer::Network.new( get_network( @defaults[:network] ) ) if @defaults[:network]
        end
        
      end
      
      class Mock

        def self.data
          @data ||= Hash.new do |hash, key|
            hash[key] = {}
          end
        end
        
        def self.reset_data(keys=data.keys)
          for key in [*keys]
            data.delete(key)
          end
        end
        
        def initialize(options={})
          @host        = options[:xenserver_pool_master]
          @username    = options[:xenserver_username]
          @password    = options[:xenserver_password]
          @connection  = Fog::Connection.new(@host)
          @connection.authenticate(@username, @password)
        end
        
      end
    end
  end
end


