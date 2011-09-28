class UserAnswer < ActiveRecord::Base
  attr_accessible :survey_result_id, :question_id, :answer_id, :content
end
