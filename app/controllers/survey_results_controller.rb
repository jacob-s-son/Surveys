class SurveyResultsController < ApplicationController
  before_filter :find_survey
  before_filter :check_ip_address, :only => [ :new ]
  
  def new
    @survey_result = SurveyResult.new_with_nested_objects(@survey)
  end

  def create
    @survey_result = SurveyResult.new
    if @survey_result.update(params[:survey_result].merge({ :survey_id => params[:survey_id], :ip_address => request.remote_ip }))
      redirect_to surveys_path, :notice => "Survey successfully filled in."
    else
      render :new
    end
  end

  private
  
  def find_survey
    @survey = Survey.find(params[:survey_id], :include => :questions)
  end
  
  def check_ip_address
    if SurveyResult.user_already_submitted?(params[:survey_id], request.remote_ip)
      flash[:error] = "You have already filled this survey!"
      redirect_to surveys_path
    end
  end
end
