class Admin::UserAnswersController < AdministratorController
  
  def index
    params[:page] ||= 1
    
    @survey = Survey.find params[:user_answer][:survey_id]
    @user_answers = @survey.user_answers.search params[:user_answer][:query], params[:user_answer][:question_id], params[:page]
    render :layout => false
  end
  
end