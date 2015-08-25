class CreateSurveys < ActiveRecord::Migration
  def change
    create_table(:surveys) do |s|
      s.column(:name, :string)
      s.column(:done, :boolean)
      s.timestamps()
   end
 end
end
