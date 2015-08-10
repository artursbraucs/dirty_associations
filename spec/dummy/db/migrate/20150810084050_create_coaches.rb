class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string :name
      t.references :team, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
