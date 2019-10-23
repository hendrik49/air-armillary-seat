module Services
  # base exeption
  class ServiceError < StandardError; end

  # some parameter is invalid
  class BadParameterError < ServiceError
    def initialize(msg ='Invalid params')
      super
    end
  end

end
