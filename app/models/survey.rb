class Survey < ActiveRecord::Base
  attr_accessible :title, :author, :description
  attr_protected :id, :created_at, :updated_at
  has_many :questions
  has_many :answers, :through => :questions
  accepts_nested_attributes_for :questions, :answers
  has_many :survey_results
  has_many :user_answers, :through => :survey_results
  validates_presence_of :title, :author, :description
  after_initialize :defaults
  
  #class methods
  class << self
    def new_with_nested_objects
      survey = Survey.new
      survey.questions.build
      survey.questions.first.answers.build
      survey
    end
  end
  
  
  def number_of_results
    survey_results.size
  end
  
  def published?
    published_flag
  end
  
  private
  def defaults
    published_flag = false if id.nil?
  end
end
