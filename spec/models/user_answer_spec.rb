require File.dirname(__FILE__) + '/../spec_helper'

describe UserAnswer do
  it { should validate_presence_of( :content, :unless => :question_has_answers? )}
  it { should validate_presence_of( :survey_result_id, :question_id )}
  it { should validate_presence_of( :answer_id, :if => :question_has_answers? )}
  it { should belong_to :question }
  it { should belong_to :answer }
  it { should belong_to :survey_result }
  it { should allow_mass_assignment_of :content }
  it { should have_columns( :question_id, :answer_id, :survey_result_id ) } #checking if foreign key exists
end