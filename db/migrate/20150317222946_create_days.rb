class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.belongs_to :week, index: true
      t.string :summary
      t.text :description

      t.timestamps null: false
    end
    add_foreign_key :days, :weeks
  end
end
