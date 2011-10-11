class SurveysController < ApplicationController
  def index
    #TODO: Maybe it's better to filter available surveys now rather than validate when saving
    @surveys = Survey.published
  end
end
