class CreateUserAndIdentityTables < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'uuid-ossp'

    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :auth_token, null: false, index: :unique

      t.timestamps null: false
    end

    create_table :identities do |t|
      t.references :user, null: false, index: true, foreign_key: true
      t.string :provider, null: false
      t.string :uid, null: false
      t.jsonb :info, null: false, default: {}
      t.jsonb :credentials, null: false, default: {}
      t.jsonb :extra, null: false, default: {}

      t.timestamps null: false
    end

    add_index :identities, [:provider, :user_id], unique: true
    add_index :identities, [:provider, :uid], unique: true
  end
end
