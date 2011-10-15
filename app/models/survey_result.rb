class SurveyResult < ActiveRecord::Base
  attr_protected :id, :survey_id, :created_at, :updated_at
  attr_accessible :user_answers_attributes, :user_answers, :ip_address
  belongs_to :survey
  has_many :user_answers
  accepts_nested_attributes_for :user_answers
  has_many :questions, :through => :survey
  validates_presence_of :survey_id, :ip_address
  validates_uniqueness_of :ip_address, :scope => :survey_id
  
  class << self
    def new_with_nested_objects(survey)
      survey_result = self.new
      survey_result.survey = survey
      user_answers = survey.questions.map { |q| UserAnswer.new(:question => q, :survey_result => survey_result) }
      survey_result.user_answers = user_answers
      survey_result
    end
    
    def user_already_submitted?(survey_id, ip_address)
      where(:survey_id => survey_id, :ip_address => ip_address).first
    end
  end
  
  def update(params)
    self.attributes = params
    self.user_answers.each { |ua| ua.survey_result = self }
    self.survey = Survey.find(params[:survey_id])
    self.save
  end
  
end
