class Admin::UserAnswersController < AdministratorController
  
  def index
    @user_answers = SurveyResult.search params[:query], params[:question_id], params[:survey_id]
  end
  
end