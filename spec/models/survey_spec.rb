require 'spec_helper'

describe Survey do
  it { should validate_presence_of( :title, :author, :description ) }
  it { should have_many :questions }
  it { should have_many( :answers, :through => :questions )}
  it { should have_many :survey_results }
  it { should have_many( :user_answers, :through => :survey_results ) }
  it { should allow_mass_assignment_of( :title, :author ) }
  it { should accept_nested_attributes_for( :questions, :answers ) }
  it { should_not allow_mass_assignment_of :id, :created_at, :updated_at }
end
