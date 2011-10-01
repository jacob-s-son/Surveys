class Answer < ActiveRecord::Base
  #TODO:search why remarkable matcher wanted a protected attributes to be listed explicity
  attr_protected :created_at, :updated_at, :question_id
  attr_accessible :content
  belongs_to :question
  validates_presence_of :question_id, :content
end
