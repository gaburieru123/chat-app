class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :room, oreign_key: true
      t.references :user, oreign_key: true
      t.timestamps
    end
  end
end
