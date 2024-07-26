class AddDeviseToAdminUsers < ActiveRecord::Migration[7.1]
  def up
    change_table :admin_users do |t|
      ## Database authenticatable
      t.string :email, null: false, default: "" unless column_exists?(:admin_users, :email)
      t.string :encrypted_password, null: false, default: "" unless column_exists?(:admin_users, :encrypted_password)

      ## Recoverable
      t.string   :reset_password_token unless column_exists?(:admin_users, :reset_password_token)
      t.datetime :reset_password_sent_at unless column_exists?(:admin_users, :reset_password_sent_at)

      ## Rememberable
      t.datetime :remember_created_at unless column_exists?(:admin_users, :remember_created_at)

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false unless column_exists?(:admin_users, :sign_in_count)
      t.datetime :current_sign_in_at unless column_exists?(:admin_users, :current_sign_in_at)
      t.datetime :last_sign_in_at unless column_exists?(:admin_users, :last_sign_in_at)
      t.string   :current_sign_in_ip unless column_exists?(:admin_users, :current_sign_in_ip)
      t.string   :last_sign_in_ip unless column_exists?(:admin_users, :last_sign_in_ip)

      ## Confirmable
      # t.string   :confirmation_token unless column_exists?(:admin_users, :confirmation_token)
      # t.datetime :confirmed_at unless column_exists?(:admin_users, :confirmed_at)
      # t.datetime :confirmation_sent_at unless column_exists?(:admin_users, :confirmation_sent_at)
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at
    end

    add_index :admin_users, :email, unique: true unless index_exists?(:admin_users, :email)
    add_index :admin_users, :reset_password_token, unique: true unless index_exists?(:admin_users, :reset_password_token)
    # add_index :admin_users, :confirmation_token, unique: true
    # add_index :admin_users, :unlock_token, unique: true
  end

  def down
    change_table :admin_users do |t|
      t.remove :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
      # t.remove :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email
      # t.remove :failed_attempts, :unlock_token, :locked_at
    end
  end
end
