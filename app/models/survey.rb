class Survey < ActiveRecord::Base
  attr_accessible :title, :author, :description, :questions_attributes
  attr_protected :id, :created_at, :updated_at
  has_many :questions, :dependent => :destroy
  has_many :answers, :through => :questions
  accepts_nested_attributes_for :questions, :answers, :allow_destroy => true
  has_many :survey_results, :dependent => :destroy
  has_many :user_answers, :through => :survey_results do
    def search (query, question_id, page)
      where([" user_answers.question_id = ? AND user_answers.content LIKE ? ", question_id, query]).page(page).per_page(5)
    end
  end
  validates_presence_of :title, :author, :description
  after_initialize :defaults
  before_validation :delete_unused_objects
  
  scope :published, where(:published_flag => true)
  
  #class methods
  class << self
    def new_with_nested_objects
      survey = Survey.new
      survey.questions.build
      survey.questions.first.answers.build
      survey
    end
  end
  
  
  def number_of_results
    survey_results.size
  end
  
  def published?
    published_flag
  end
  
  private
  def defaults
    published_flag = false if id.nil?
  end
  
  def delete_unused_objects
    questions.delete_if {|q| q.id.nil? && q.marked_for_destruction? }.each do |q|
      q.survey = self
      q.answers.delete_if {|a| ( a.id.nil? && a.marked_for_destruction? ) || q.question_type != 'option' }
    end
  end
end
