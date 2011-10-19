class Admin::SurveyResultsController < AdministratorController
  def index 
    @survey = Survey.find params[:survey_id]
    @survey_results = @survey.survey_results    
  end
end