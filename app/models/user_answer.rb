class UserAnswer < ActiveRecord::Base
  attr_accessible :content, :question, :survey_result, :question_id, :answer_id
  belongs_to :question
  belongs_to :survey_result
  belongs_to :answer
  validates_presence_of :question_id, :survey_result
  validates_presence_of :answer_id, :if => :question_has_answers?
  validates :content, :presence => { :unless => :question_has_answers?, :message => 'can\'t be blank', :allow_blank => false }, 
                      :format => { :with => /^[0-9]+$/, :if => :answer_type_number?, :message => 'must be a number' }
                      
  
  def question_has_answers?
    question.has_answers?
  end
  
  def answer_type_number?
    type_is?('number')
  end
  
  def type_is?(type_to_check)
    question.question_type == type_to_check
  end
end
