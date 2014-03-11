class RenamePasswordToEncPassword < ActiveRecord::Migration
  def change
  	rename_column :users, :password, :enc_password
  end
end
