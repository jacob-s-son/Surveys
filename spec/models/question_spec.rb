require 'spec_helper'

describe Question do
  before { FactoryGirl.create :question }
  it { should have_many :user_answers }
  it { should belong_to :survey }
  it { should have_column :survey_id } #checking if foreign key exists
  it { should have_many :answers }
  it { should accept_nested_attributes_for :answers }
  it { should validate_presence_of :content }
  it { should validate_presence_of :survey_id }
  it { should allow_mass_assignment_of :content }
  it { should_not allow_mass_assignment_of :id, :created_at, :updated_at, :survey_id }
end
