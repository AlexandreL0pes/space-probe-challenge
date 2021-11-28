class CreateSpaceProbes < ActiveRecord::Migration[6.1]
  def change
    create_table :space_probes do |t|
      t.integer :position_x
      t.integer :position_y
      t.string :front_direction

      t.timestamps
    end
  end
end
