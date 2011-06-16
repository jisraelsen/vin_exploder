
module VinExploder
  
  class Explosion
    
    attr_reader :vin, :success, :errors, :make, :model, :year, :driveline, :body_style, :all
    
    def initialize(vin, vin_hash, errors={})
      @vin = vin
      @all = vin_hash
      @make = all[:make]
      @model = all[:model]
      @year = all[:year]
      @driveline = all[:driveline]
      @body_style = all[:body_style]
      @fuel_type = all[:fuel_type]
      @trim_level = all[:trim_level]
      @errors = errors
      @success = errors.empty?
    end
    
    def valid?
      @success
    end
    alias :success? :valid?
    
  end
  
end