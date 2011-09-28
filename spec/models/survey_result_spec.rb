require File.dirname(__FILE__) + '/../spec_helper'

describe SurveyResult do
  it { should validate_presence_of :ip_address }
  it { should have_many :user_answers }
  it { should have_many( :questions, :through => :user_answers ) }
  it { should belong_to :survey }
  it { should accept_nested_attributes_for :user_answers }
  it { should have_column :survey_id } #checking if foreign key exists
end