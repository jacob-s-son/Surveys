require File.dirname(__FILE__) + '/../spec_helper'

describe SurveyResultsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => SurveyResult.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    SurveyResult.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    SurveyResult.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(survey_result_url(assigns[:survey_result]))
  end

  it "edit action should render edit template" do
    get :edit, :id => SurveyResult.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    SurveyResult.any_instance.stubs(:valid?).returns(false)
    put :update, :id => SurveyResult.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    SurveyResult.any_instance.stubs(:valid?).returns(true)
    put :update, :id => SurveyResult.first
    response.should redirect_to(survey_result_url(assigns[:survey_result]))
  end

  it "destroy action should destroy model and redirect to index action" do
    survey_result = SurveyResult.first
    delete :destroy, :id => survey_result
    response.should redirect_to(survey_results_url)
    SurveyResult.exists?(survey_result.id).should be_false
  end
end
