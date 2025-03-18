class AddAmountToMessages < ActiveRecord::Migration[7.2]
  def change
    add_column :messages, :amount, :integer
  end
end
