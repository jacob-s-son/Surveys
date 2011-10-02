class AddPublishedFlagToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :published_flag, :boolean
  end
end
