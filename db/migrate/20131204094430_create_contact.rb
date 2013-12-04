class CreateContact < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email, null: false
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :comment, null: false
    end
  end
end
