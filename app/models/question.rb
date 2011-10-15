class Question < ActiveRecord::Base
  attr_accessible :content, :question_type, :answers_attributes
  # attr_protected :id, :created_at, :updated_at, :survey_id
  belongs_to :survey
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers
  has_many :user_answers
  validates_presence_of :content, :survey
  after_initialize :set_defaults
  
  ANSWER_TYPES = [ "text", "number", "option" ]
  
  def has_answers?
    answers.first #if first exists method evaluates to true
  end
  
  def data_for_chart
    return [] unless type_is?('option')
    answers.map { |a| [ a.content, UserAnswer.count(:conditions => ["question_id = ? AND answer_id = ? ", self.id, a.id]) ] }
  end
  
  def type_is?(type_to_check)
    question_type == type_to_check
  end
  
  private
  def set_defaults
    self.question_type = 'text' if id.nil? && question_type.nil?
  end
end
