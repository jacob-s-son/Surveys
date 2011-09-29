class UserAnswer < ActiveRecord::Base
  attr_accessible :content
  belongs_to :question
  belongs_to :survey_result
  belongs_to :answer
  validates_presence_of :question_id, :survey_result_id
  validates_presence_of :content, :unless => :question_has_answers?
  validates_presence_of :answer_id, :if => :question_has_answers?
end
