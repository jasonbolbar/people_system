class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, limit:254
      t.string :job
      t.text :bio
      t.integer :gender
      t.date :birth_date
      t.string :picture

      t.timestamps null: false
    end

    add_index :people, :email, unique: true

  end
end
