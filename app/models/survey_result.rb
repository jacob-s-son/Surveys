class SurveyResult < ActiveRecord::Base
  attr_accessible :ip_address
  attr_protected :id, :created_at, :updated_at, :survey_id
  belongs_to :survey
  has_many :user_answers
  accepts_nested_attributes_for :user_answers
  has_many :questions, :through => :survey
  validates_presence_of :survey_id
  validates_uniqueness_of :ip_address, :scope => :survey_id
end
