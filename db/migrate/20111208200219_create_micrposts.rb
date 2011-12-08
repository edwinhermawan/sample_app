class CreateMicrposts < ActiveRecord::Migration
  def self.up
    create_table :micrposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :micrposts, :user_id
  end

  def self.down
    drop_table :micrposts
  end
end
