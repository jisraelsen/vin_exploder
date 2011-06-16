
module VinExploder
  
  module Cache
    
    
    # An abstract cache store class that acts as a null cache as well
    class Store
      
      attr_reader :connection
      
      # Create a new cache.
      def initialize(options = nil)
        @options = options ? options.dup : {}
      end
      
      # Fetches VIN data from the cache using the given key. If the VIN has been
      # cached, then the VIN attributes are returned.
      #
      # If the VIN is not in the cache (a cache miss occurred),
      # then nil will be returned. However, if a block has been passed, then
      # that block will be run in the event of a cache miss. The return value
      # of the block will be written to the cache under the given VIN,
      # and that return value will be returned.
      #
      #   cache.write("VIN_NUMBER", {:make => 'Ford', :model => 'F150'})
      #   cache.fetch("VIN_NUMBER")  # => {:make => 'Ford', :model => 'F150'}
      #
      #   cache.fetch("VIN_NUMBER_2")   # => nil
      #   cache.fetch("VIN_NUMBER_2") do
      #     {:make => 'Dodge', :model => '1500'}
      #   end
      #   cache.fetch("VIN_NUMBER_2")   # => {:make => 'Dodge', :model => '1500'}
      #
      def fetch(vin)
        if block_given?
          explosion = read(vin)
          if explosion.nil?
            vin_attrs = yield 
            write(vin, vin_attrs)
          end
        else
          read(vin)
        end
      end
    
      # Fetches VIN data from the cache, using the given key. If VIN has
      # been cached with the given key, then the VIN attributes are returned. Otherwise,
      # nil is returned.
      def read(vin)
        nil
      end
    
      # Writes the value to the cache, with the key.
      def write(vin, vin_attrs)
        vin_attrs
      end
      
      # Deletes an entry in the cache. Returns +true+ if an entry is deleted.
      def delete(vin)
        true
      end
      
      protected
      
      # the cache key for vins should be based on characters 0-8, 10-11. 
      # Position 9 is a checksum value and should not be used in the key.
      def make_vin_cache_key(vin)
        key = vin.slice(0,9)
        key << vin.slice(10,2)
      end
    
    end
  end
  
end