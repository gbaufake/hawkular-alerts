require 'uri'
require 'net/http'
require 'openssl'

class TestCase
def initialize(parameters, headers)
  @name = parameters["name"]
  @url = URI(parameters["hawkular-environment"] + parameters["hawkular-url"])
  @http = Net::HTTP.new(@url.host, @url.port)
  @http.use_ssl = parameters["ssl"]
  @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  case parameters["http-method"]

  when 'GET'
    @request = Net::HTTP::Get.new(@url)
    configure_base_request(headers)

  when 'POST'
    @request = Net::HTTP::Post.new(@url)
    configure_base_request(headers)
    configure_body_request(parameters["body"])

  when 'DELETE'
    @request = Net::HTTP::Delete.new(@url)
    configure_base_request(headers)

  when 'PUT'
    @request = Net::HTTP::Put.new(@url)
    configure_base_request(headers)
  end
end

def configure_base_request(headers)
  headers.each do |key, value|
    @request[key.to_s] = value
  end
end


def configure_body_request(body)
  @request.body=body
end

def peform_request
  return @http.request(@request)
end



end
