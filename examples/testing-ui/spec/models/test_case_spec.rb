require 'rails_helper'

RSpec.describe TestCase, type: :model do
  before(:each) do
    @parameters = {"name" =>"Pushing Triggers", "hawkular-environment" => ENV['HAWKULAR_ENVIRONMENT'],
      "hawkular-url" => "hawkular/alerts/import/all", "ssl"=> ENV['HAWKULAR_USE_SSL'], "http-method"=> 'POST'}

      @headers = {"hawkular-tenant" => ENV['HAWKULAR_TENANT'],
          "content-type" => 'application/json',
           "authorization" => ENV['HAWKULAR_TOKEN'],
           "cache-control" => 'no-cache'}
   end

  it "HTTP Response should be 200 if body is not empty" do
    # @parameters["body"] = JSON.parse(File.read('spec/models/autoresolve-trigger.json')).to_json
    # test_case = TestCase.create(:parameters => @parameters, :headers => @headers)
    test_case = TestCase.first
    response = test_case.peform_request
    expect(response.code).to  eq("200")
  end

 # it "HTTP Response should be 400 if body is empty" do
 #    @parameters["body"] = ''
 #    # test_case = TestCase.new(@parameters, @headers)
 #    # test_case.save
 #    # response = test_case.peform_request
 #    # expect(response.code).to  eq("400")
 # end
end
