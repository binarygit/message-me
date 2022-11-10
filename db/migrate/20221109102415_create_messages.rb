class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :author_id
      t.string :description

      t.timestamps
    end
  end
end
