class SurveyResult < ActiveRecord::Base
  attr_accessible :ip_address
  belongs_to :survey
  has_many :user_answers
  has_many :questions, :through => :survey
end
