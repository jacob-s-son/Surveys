require File.dirname(__FILE__) + '/../spec_helper'

describe Answer do
  it { should validate_presence_of :content }
  it { should belong_to :question }
  it { should allow_mass_assignment_of :content }
  it { should have_column :question_id } #checking if foreign key exists
end
