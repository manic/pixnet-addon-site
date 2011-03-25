class CreateAkismets < ActiveRecord::Migration
  def self.up
    create_table :akismets do |t|
      t.integer :user_id
      t.string  :apikey
      t.boolean :enabled, :default => true
      t.timestamps
    end
    add_index :akismets, :user_id
  end

  def self.down
    drop_table :akismets
  end
end
