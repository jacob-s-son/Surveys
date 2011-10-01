require 'spec_helper'

describe Answer do
  it { should belong_to :question }
  it { should have_column :question_id } #checking if foreign key exists
  it { should validate_presence_of( :content, :question_id ) }
  it { should allow_mass_assignment_of :content }
  it { should_not allow_mass_assignment_of( :id, :created_at, :updated_at, :question_id ) }
end
