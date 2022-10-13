class AddExternalAuthIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :external_auth_id, :string
  end
end
