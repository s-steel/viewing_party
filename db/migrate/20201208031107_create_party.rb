class CreateParty < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.bigint :movie_id
      t.integer :duration
      t.datetime :when
      t.bigint :host_id
    end
    add_foreign_key :parties, :users, column: :host_id
  end
end
