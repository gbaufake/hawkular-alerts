require 'rails_helper'

RSpec.describe TestCase, type: :model do
  before(:each) do
    # @parameters = {:name =>"Pushing Triggers", :hawkular_environment => 'http://localhost:8080/',
    #   :hawkular_endpoint => "hawkular/alerts/import/all",  :ssl=> 'false', :http_method=> 'POST'}
    #
    #   @headers = {:hawkular_tenant => 'hawkular',
    #       :content_type => 'application/json',
    #        :authorization => 'Basic amRvZTpwYXNzd29yZA==',
    #        :cache_control => 'no-cache'}
   end

  it "HTTP Response should be 200 if body is not empty" do
    # @parameters["body"] = JSON.parse(File.read('spec/models/autoresolve-trigger.json')).to_json
    # test_case = TestCase.create(:parameters => @parameters, :headers => @headers)
    test_case = TestCase.first


    time = Benchmark.measure do
      response = test_case.peform_request.code
      print time
      expect(response).to eq("200")
    end
    print time


  end

end
