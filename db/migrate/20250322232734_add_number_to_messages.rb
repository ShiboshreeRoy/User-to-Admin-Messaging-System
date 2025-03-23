class AddNumberToMessages < ActiveRecord::Migration[7.2]
  def change
    add_column :messages, :number, :string
  end
end
