module Api
  class Model
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations
    
    def formatted_errors
      self.errors.messages.reduce([]) { |arr, (k, v)| arr << { "#{k}": v} }
    end  
  end  
end    