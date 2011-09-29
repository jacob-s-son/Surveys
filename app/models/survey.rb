class Survey < ActiveRecord::Base
  attr_accessible :title, :author
  has_many :questions
  has_many :answers, :through => :questions
  has_many :survey_results
  has_many :user_answers, :through => :survey_results
  accepts_nested_attributes_for :questions, :answers
end
