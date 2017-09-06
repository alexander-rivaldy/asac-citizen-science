class CreateSamples < ActiveRecord::Migration[5.1]
  def change
    create_table :samples do |t|
      t.string :name
      t.float :lat
      t.string :lat_type
      t.float :lon
      t.string :lon_type
      t.date :taken
      t.string :description
      t.float :mass
      t.float :fluidmass
      t.float :fluidmassrecovered
      t.float :ph
      t.float :conductivity
      t.float :bicarbonate_alkalinity
      t.float :carbonate_alkalinity
      t.float :total_alkalinity
      t.float :sulphate
      t.float :fluoride
      t.float :calcium
      t.float :magnesium
      t.float :sodium
      t.float :potassium
      t.float :silver
      t.float :aluminium
      t.float :arsenic
      t.float :barium
      

      t.timestamps
    end
  end
end
