class CreateQuestionsAnswers < ActiveRecord::Migration
  def change
    create_table(:questions_answers) do |qa|
      qa.belongs_to(:question, index: true)
      qa.belongs_to(:answer, index: true)

      qa.timestamps()
    end
  end
end
