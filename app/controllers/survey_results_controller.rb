class SurveyResultsController < ApplicationController
  before_filter :find_survey
  
  def new
    @survey_result = SurveyResult.new_with_nested_objects(@survey)
  end

  def create
    @survey_result = SurveyResult.new(params[:survey_result].merge(:survey_id => params[:survey_id]))
    if @survey_result.save
      redirect_to @survey_result, :notice => "Successfully created survey result."
    else
      render :new
    end
  end

  private
  
  def find_survey
    @survey = Survey.find(params[:survey_id], :include => :questions)
  end
end
