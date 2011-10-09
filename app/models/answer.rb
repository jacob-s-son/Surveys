class Answer < ActiveRecord::Base
  attr_accessible :content, :question_id
  # attr_protected :id, :created_at, :updated_at, :question_id
  belongs_to :question
  validates_presence_of :content
end
