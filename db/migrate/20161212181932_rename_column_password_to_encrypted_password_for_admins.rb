class RenameColumnPasswordToEncryptedPasswordForAdmins < ActiveRecord::Migration[5.0]
  def change
    rename_column :admins, :password, :encrypted_password
  end
end
