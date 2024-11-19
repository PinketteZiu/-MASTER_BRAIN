class AddCompetenceToBrains < ActiveRecord::Migration[7.1]
  def change
    add_column :brains, :competence, :string
  end
end
