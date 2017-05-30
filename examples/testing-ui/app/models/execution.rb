class Execution
  include Mongoid::Document
  include Mongoid::Timestamps

  field :expected_response_code
  field :time_of_response

  field :actual_response_code
  field :actual_response_body
  belongs_to :test_case

  def success
    if self.expected_response_code == actual_response_code
      return "Yes"
    else
      return "No"
    end
  end
end
