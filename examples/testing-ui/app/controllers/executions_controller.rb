class ExecutionsController < ApplicationController
  before_action :set_execution, only: [:show, :destroy]

  # GET /executions
  # GET /executions.json
  def index
    @test_case = TestCase.find(params[:test_case_id ])
    @executions = @test_case.executions
  end

  # GET /executions/1
  # GET /executions/1.json
  def show
    @test_case = TestCase.find(params[:test_case_id ])
  end

  # GET /executions/new
  def new
    @test_case = TestCase.find(params[:test_case_id ])
    @execution = Execution.new
  end

  # POST /executions
  # POST /executions.json
  def create
    @execution = Execution.new(execution_params)
    @test_case = TestCase.find(params[:test_case_id ])
    @execution.test_case = @test_case
    execute
    if @execution.save
      redirect_to test_case_executions_path(@test_case), notice: 'Execution was successfully created.'
    else
      flash.now[:error] = "Couldn't run the execution on #{@test_case.parameters[:hawkular_environment]} - Connection Refused"
      render :new
    end
  end


  # DELETE /executions/1
  # DELETE /executions/1.json
  def destroy
    @execution.destroy
    respond_to do |format|
      format.html { redirect_to test_case_executions_url, notice: 'Execution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_execution
      @execution = Execution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def execution_params
      params.require(:execution).permit(:expected_response_code, :test_case_id)
    end

    def execute
    time = Benchmark.measure do
      response = @execution.perform_request
    end
    response = @execution.perform_request
    @execution.actual_response_code = response.code
    @execution.actual_response_body = response.body
    @execution.time_of_response = time.real
    @execution.save
    end
end
