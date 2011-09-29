class Question < ActiveRecord::Base
  attr_accessible :content
  belongs_to :survey
  has_many :answers
  accepts_nested_attributes_for :answers
end
