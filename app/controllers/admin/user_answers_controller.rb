class Admin::UserAnswersController < AdministratorController
  respond_to :html, :js
  
  def index
    params[:page] ||= 1
    
    @survey = Survey.find params[:user_answer][:survey_id]
    @user_answers = @survey.user_answers.search params[:user_answer][:query], params[:user_answer][:question_id], params[:page]
    
    respond_with do |format|
      format.html do
        render :index, :layout => false      
      end
      format.js do
        render :index, :layout => false      
      end
    end
  end
  
end