class AddStatusToMessages < ActiveRecord::Migration[7.2]
  def change
    add_column :messages, :status, :string, default: 'pending'
  end
end
