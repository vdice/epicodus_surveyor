class Answers < ActiveRecord::Migration
  def change
    create_table(:answers) do |a|
      a.column(:name, :string)

      a.timestamps()
    end
  end
end
