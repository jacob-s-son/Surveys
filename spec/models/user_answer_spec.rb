require 'spec_helper'

describe UserAnswer do
  it { should belong_to :question }
  it { should belong_to :answer }
  it { should belong_to :survey_result }
  it { should allow_mass_assignment_of :content }
  it { should have_columns( :question_id, :answer_id, :survey_result_id ) } #checking if foreign key exists
  
  describe "Validations" do
    #TODO something wrong with this matcher
    # before { @ua = Factory :user_answer; @ua.stub!(:question_has_answer?).and_return(true) }
    # it { @ua.should validate_presence_of( :survey_result_id, :question_id )}
    
    context "Question has prepared answers, custom answer is not filled" do
      before { @ua = Factory :user_answer_custom }
      it { @ua.should be_valid }
    end
    
    context "Question has not prepared answers, custom answer is filled" do      
      before { @ua = Factory :user_answer_custom }
      it { @ua.should be_valid}
    end
  end
end