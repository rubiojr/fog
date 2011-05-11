module Fog
  module Ninefold
    class Compute
      class Real

        def enable_static_nat(options = {})
          request('enableStaticNat', options, :expects => [200],
                  :response_prefix => 'enablestaticnatresponse', :response_type => Hash)
        end

      end

      class Mock

        def enable_static_nat(*args)
          Fog::Mock.not_implemented
        end

      end

    end
  end
end
