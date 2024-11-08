class CreateOffices < ActiveRecord::Migration[7.2]
  def change
    create_table :offices do |t|
      t.string :office_name
      t.string :tel
      t.string :address

      t.timestamps
    end
  end
end
