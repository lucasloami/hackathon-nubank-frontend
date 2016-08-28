class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.belongs_to :task
      t.belongs_to :mission
      t.string :token
      t.string :title
      t.text :content
      t.string :type
      t.timestamps
    end

    create_table :message_users do |t|
      t.belongs_to :message
      t.belongs_to :user
      t.timestamps
    end

    add_index :message_users, [:message_id, :user_id], unique: true

  end
end
