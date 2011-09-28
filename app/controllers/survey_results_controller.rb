class SurveyResultsController < ApplicationController
  def index
    @survey_results = SurveyResult.all
  end

  def show
    @survey_result = SurveyResult.find(params[:id])
  end

  def new
    @survey_result = SurveyResult.new
  end

  def create
    @survey_result = SurveyResult.new(params[:survey_result])
    if @survey_result.save
      redirect_to @survey_result, :notice => "Successfully created survey result."
    else
      render :new
    end
  end

  def edit
    @survey_result = SurveyResult.find(params[:id])
  end

  def update
    @survey_result = SurveyResult.find(params[:id])
    if @survey_result.update_attributes(params[:survey_result])
      redirect_to @survey_result, :notice  => "Successfully updated survey result."
    else
      render :edit
    end
  end

  def destroy
    @survey_result = SurveyResult.find(params[:id])
    @survey_result.destroy
    redirect_to survey_results_url, :notice => "Successfully destroyed survey result."
  end
end
