class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.belongs_to :course, index: true
      t.integer :number, null: false
      t.text :goals
      t.text :plans
      t.text :project
    end
    add_foreign_key :weeks, :courses
  end
end
