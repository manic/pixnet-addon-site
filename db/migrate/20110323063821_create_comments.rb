class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id
      t.integer :pixnet_comment_id
      t.string  :author
      t.string  :author_email
      t.string  :author_url
      t.string  :comment_type, :default => "comment"
      t.string  :content
      t.string  :permalink
      t.string  :user_ip
      t.boolean :confirmed, :default => false
      t.boolean :checked_spam
      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, [:user_id, :pixnet_comment_id], :unique => true
  end

  def self.down
    drop_table :comments
  end
end
