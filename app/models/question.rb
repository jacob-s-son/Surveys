class Question < ActiveRecord::Base
  attr_accessible :content
  attr_protected :survey_id, :created_at, :updated_at, :id
  belongs_to :survey
  has_many :answers
  accepts_nested_attributes_for :answers
  has_many :user_answers
  validates_presence_of :content, :survey_id
end
