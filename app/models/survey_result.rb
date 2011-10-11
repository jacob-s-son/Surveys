class SurveyResult < ActiveRecord::Base
  attr_protected :id, :survey_id, :created_at, :updated_at
  belongs_to :survey
  has_many :user_answers
  accepts_nested_attributes_for :user_answers
  has_many :questions, :through => :survey
  validates_presence_of :survey_id
  validates_uniqueness_of :ip_address, :scope => :survey_id
  
  class << self
    def new_with_nested_objects(survey)
      survey_result = self.new
      survey_result.survey = survey
      user_answers = survey.questions.map { |q| UserAnswer.new(:question => q, :survey_result => survey_result) }
      survey_result.user_answers = user_answers
      survey_result
    end
  end
  
end
