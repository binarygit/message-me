class CreateLoginInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :login_invitations do |t|
      t.string :email
      t.string :unique_hash

      t.timestamps
    end
  end
end
