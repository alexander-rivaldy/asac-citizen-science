class AddPictureUrlToSamples < ActiveRecord::Migration[5.1]
  def change
    add_column :samples, :picture, :string
  end
end
