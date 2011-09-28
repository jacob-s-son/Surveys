class CreateUserAnswers < ActiveRecord::Migration
  def self.up
    create_table :user_answers do |t|
      t.integer :survey_result_id
      t.integer :question_id
      t.integer :answer_id
      t.string :content
      t.timestamps
    end
  end

  def self.down
    drop_table :user_answers
  end
end
