class CreateQuestions < ActiveRecord::Migration
  def change
    create_table(:questions) do |q|
      q.column(:query, :string)
      q.column(:survey_id, :int)

      q.timestamps()
    end
  end
end
