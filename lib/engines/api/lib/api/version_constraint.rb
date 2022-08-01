module Api
  class VersionConstraint
    def initialize(options)
      @version = options[:version]
      @default = options[:default]
    end  
    
    def matches?(req)
      @default || req.headers['Accept'].include?("application/vnd.bookstores-inventory.v#{@version}+json")
    end  
  end
end    