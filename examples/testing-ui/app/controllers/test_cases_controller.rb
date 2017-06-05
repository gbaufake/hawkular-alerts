class TestCasesController < ApplicationController
  before_action :set_test_case, only: [:show, :edit, :update, :destroy]

  # GET /test_cases
  # GET /test_cases.json
  def index
    @test_cases = TestCase.all
  end

  # GET /test_cases/1
  # GET /test_cases/1.json
  def show
  end

  # GET /test_cases/new
  def new
    @test_case = TestCase.new
  end

  # GET /test_cases/1/edit
  def edit
  end

  # POST /test_cases
  # POST /test_cases.json
  def create

    @test_case = TestCase.new(test_case_params)
    respond_to do |format|
      if @test_case.save
        @test_case.headers[:authorization] = "Basic " + Base64.encode64( "#{@test_case.user}:{#{@test_case.password}")
        @test_case.save
        format.html { redirect_to test_cases_path, notice: 'Test case was successfully created.' }
        format.json { render :show, status: :created, location: @test_case }
      else
        format.html { render :new }
        format.json { render json: @test_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_cases/1
  # PATCH/PUT /test_cases/1.json
  def update
    respond_to do |format|
      if @test_case.update(test_case_params)
        @test_case.headers[:authorization] = "Basic " + Base64.encode64( "#{@test_case.user}:{#{@test_case.password}")
        @test_case.save
        format.html { redirect_to test_cases_path, notice: 'Test case was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /test_cases/1
  # DELETE /test_cases/1.json
  def destroy
    @test_case.destroy
    respond_to do |format|
      format.html { redirect_to test_cases_url, notice: 'Test case was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_case
      @test_case = TestCase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_case_params

      params.require(:test_case).permit(:user, :password, parameters: [:name, :ssl, :hawkular_environment, :hawkular_endpoint, :http_method, :body], headers: [:hawkular_tenant, :content_type, :cache_control])

    end
end
