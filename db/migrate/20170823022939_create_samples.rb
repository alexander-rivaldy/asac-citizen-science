class CreateSamples < ActiveRecord::Migration[5.1]
  def change
    create_table :samples do |t|
      t.int :lat
      t.int :lon

      t.timestamps
    end
  end
end
