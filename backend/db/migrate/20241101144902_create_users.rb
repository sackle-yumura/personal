class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :screen_name
      t.integer :department_id
      t.integer :office_id
      t.integer :status

      t.timestamps
    end
  end
end
