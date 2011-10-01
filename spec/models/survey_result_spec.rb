require 'spec_helper'

describe SurveyResult do
  before { FactoryGirl.create :survey_result }
  it { should have_many :user_answers }
  it { should accept_nested_attributes_for :user_answers }
  it { should have_many( :questions, :through => :survey ) }
  it { should belong_to :survey }
  it { should have_column :survey_id } #checking if foreign key exists
  it { should validate_presence_of :survey_id }
  it { should validate_uniqueness_of( :ip_address, :scope => :survey_id ) }
  it { should_not allow_mass_assignment_of :id, :created_at, :updated_at, :survey_id }
end