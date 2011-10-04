class Question < ActiveRecord::Base
  attr_accessible :content
  attr_protected :id, :created_at, :updated_at, :survey_id
  belongs_to :survey
  has_many :answers
  accepts_nested_attributes_for :answers
  has_many :user_answers
  validates_presence_of :content, :survey_id

  attr_accessor :type
  
  def has_answers?
    answers.first #if first exists method evaluates to true
  end
end
