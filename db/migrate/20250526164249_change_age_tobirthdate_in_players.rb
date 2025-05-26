class ChangeAgeTobirthdateInPlayers < ActiveRecord::Migration[8.0]
  def change
    remove_column :players, :age, :integer
    add_column :players, :birthdate, :date
  end
end
