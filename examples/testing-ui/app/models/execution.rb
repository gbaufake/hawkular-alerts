class Execution
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body
  field :expected_response_code
  field :time_of_response

  field :actual_response_code
  field :actual_response_body
  belongs_to :test_case

  validates_presence_of :actual_response_code

  def success
    if self.expected_response_code.to_s == actual_response_code.to_s
      return "Yes"
    else
      return "No"
    end
  end

  def request
    response = RestClient::Resource.new(self.test_case.url, :headers=> self.test_case.http_headers)
  end

  def perform_request
  begin
    case self.test_case.http_method
    when 'GET'
      return self.request.get

    when 'POST'
      byebug
      return self.request.post(self.body)

    when 'DELETE'
      return self.request.delete

    when 'PUT'
       return self.request.put(self.body)
      end
    rescue RestClient::ExceptionWithResponse => e
      return e.response
    end
end
  # def url
  #   @url = URI(self.test_case.hawkular_environment+ self.test_case.hawkular_endpoint)
  # end
  #
  # def http
  #   @http = Net::HTTP.new(self.url.host, self.url.port)
  #   @http.use_ssl = self.test_case.ssl
  #   @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  #   return @http
  # end
  #
  # def request
  #   case self.parameters[:http_method]
  #     when 'GET'
  #       request = Net::HTTP::Get.new(@url)
  #        return configure_base_request(self.headers, request)
  #
  #      when 'POST'
  #        request = Net::HTTP::Post.new(@url)
  #        request.body = self.parameters[:body]
  #        return configure_base_request(self.headers, request)
  #
  #      when 'DELETE'
  #        request = Net::HTTP::Delete.new(@url)
  #        return configure_base_request(headers, request)
  #
  #      when 'PUT'
  #        request = Net::HTTP::Put.new(@url)
  #        return configure_base_request(headers, request)
  #      end
  # end
  #
  # def configure_base_request(headers, request)
  #   headers.each do |key, value|
  #     request[key.gsub(/_/, "-")] = value
  #   end
  #   return request
  # end
  # def peform_request
  #   begin
  #     return self.http.request(self.request)
  #   rescue
  #     rescue Errno::ECONNREFUSED
  #   end
  # end






end
