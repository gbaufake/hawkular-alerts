class TestCase
  include Mongoid::Document
  field :parameters, type: Hash
  field :headers, type: Hash

  has_many :executions


  def url
    @url = URI(self.parameters[:hawkular_environment] + self.parameters[:hawkular_endpoint])
  end

  def name
    return self.parameters[:name]
  end

  def http

    @http = Net::HTTP.new(self.url.host, self.url.port)
    @http.use_ssl = self.parameters[:ssl].to_bool
    @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    return @http
  end

  def request
    case self.parameters[:http_method]
      when 'GET'
        request = Net::HTTP::Get.new(@url)
         return configure_base_request(self.headers, request)

       when 'POST'
         request = Net::HTTP::Post.new(@url)
         request.body = self.parameters[:body]
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
      request[key.gsub(/_/, "-")] = value
    end
    return request
  end
  def peform_request
    return self.http.request(self.request)
  end
end
