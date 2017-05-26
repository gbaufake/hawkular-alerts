class TestCase
  include Mongoid::Document
  field :parameters, type: Hash
  field :headers, type: Hash


  def url
    @url = URI(self.parameters["hawkular-environment"] + self.parameters["hawkular-url"])
  end

  def http

    @http = Net::HTTP.new(self.url.host, self.url.port)
    @http.use_ssl = self.parameters["ssl"].to_bool
    @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    return @http
  end

  def request
    case self.parameters["http-method"]
      when 'GET'
        request = Net::HTTP::Get.new(@url)
         return configure_base_request(self.headers, request)

       when 'POST'
         request = Net::HTTP::Post.new(@url)
         request.body = self.parameters["body"]
         return configure_base_request(self.headers, request)

       when 'DELETE'
         request = Net::HTTP::Delete.new(@url)
         return configure_base_request(headers)

       when 'PUT'
         request = Net::HTTP::Put.new(@url)
         return configure_base_request(headers)
       end
  end

  def configure_base_request(headers, request)
    headers.each do |key, value|
      request[key.to_s] = value
    end
    return request
  end
  def peform_request
    return self.http.request(self.request)
  end







  # def initialize(parameters, headers)
  #   byebug
  #   self.parameters = parameters
  #   @name = parameters["name"]
  #   @url = URI(parameters["hawkular-environment"] + parameters["hawkular-url"])
  #   @http = Net::HTTP.new(@url.host, @url.port)
  #   @http.use_ssl = parameters["ssl"]
  #   @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  #   case parameters["http-method"]
  #
  #   when 'GET'
  #     @request = Net::HTTP::Get.new(@url)
  #     configure_base_request(headers)
  #
  #   when 'POST'
  #     @request = Net::HTTP::Post.new(@url)
  #     configure_base_request(headers)
  #     configure_body_request(parameters["body"])
  #
  #   when 'DELETE'
  #     @request = Net::HTTP::Delete.new(@url)
  #     configure_base_request(headers)
  #
  #   when 'PUT'
  #     @request = Net::HTTP::Put.new(@url)
  #     configure_base_request(headers)
  #   end
  # end
  #
  # def configure_base_request(headers)
  #   headers.each do |key, value|
  #     @request[key.to_s] = value
  #   end
  # end
  #
  #
  # def configure_body_request(body)
  #   @request.body=body
  # end
  #
  # def peform_request
  #   return @http.request(@request)
  # end
end
