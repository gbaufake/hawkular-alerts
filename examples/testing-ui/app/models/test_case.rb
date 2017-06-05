class TestCase
  include Mongoid::Document
  field :parameters, type: Hash
  field :headers, type: Hash
  field :user, type: String
  field :password, type: String

  has_many :executions


  def name
    return self.parameters[:name]
  end

  def url
    return self.parameters[:hawkular_environment] + self.parameters[:hawkular_endpoint]
  end

  def ssl
    return self.parameters[:ssl].to_bool
  end

  def http_method
    return self.parameters[:http_method]
  end

  def http_headers()
    headers_modified = {}
    self.headers.each do |key, value|
      headers_modified[key.gsub(/_/, "-")] = value
    end
    headers_modified[:authorization] = "Basic " + Base64.encode64( "#{self.user}:{#{self.password}")
    return headers_modified
  end

end
