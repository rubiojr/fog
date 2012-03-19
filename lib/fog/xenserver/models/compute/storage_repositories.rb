require 'fog/core/collection'
require 'fog/xenserver/models/compute/storage_repository'

module Fog
  module Compute
    class XenServer

      module Collections
        def storage_repositories
          Fog::Compute::XenServer::StorageRepositories.new(:connection => self)
        end
      end

      class StorageRepositories < Fog::Collection

        model Fog::Compute::XenServer::StorageRepository

        #def all
        #  data = connection.get_storage_repositories
        #  load(data)
        #  #@response << sr if sr[:shared] and !sr[:content_type].eql?('iso')
        #end
        
        def all
          data = connection.get_storage_repositories
          #data.delete_if {|sr| sr[:shared].eql?(false)}
          #data.delete_if {|sr| sr[:content_type].eql?('iso')}
          load(data)
        end

        def get( sr_ref )
          if sr_ref && sr = connection.get_storage_repository_by_ref( sr_ref )
            new(sr)
          end
        rescue Fog::Compute::XenServer::NotFound
          nil
        end

      end

    end
  end
end
