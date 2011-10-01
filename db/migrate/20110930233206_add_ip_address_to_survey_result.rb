class AddIpAddressToSurveyResult < ActiveRecord::Migration
  def change
    add_column :survey_results, :ip_address, :string
  end
end
