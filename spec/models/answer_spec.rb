require 'spec_helper'

describe Answer do
  it { should validate_presence_of( :content, :survey_id ) }
  it { should belong_to :question }
  it { should allow_mass_assignment_of :content }
  it { should_not allow_mass_assignment_of :id, :created_at, :updated_at, :question_id }
  it { should have_column :question_id } #checking if foreign key exists
end
