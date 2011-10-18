class Admin::UserAnswersController < AdministratorController
  
  def index
    @survey = params[:survey_id]
    params[:page] ||= 1
    @user_answers = @survey.user_answers.search params[:query], params[:question_id], params[:page]
  end
  
end