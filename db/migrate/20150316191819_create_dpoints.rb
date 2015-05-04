class CreateDpoints < ActiveRecord::Migration
  def change
    create_table :dpoints do |t|
      t.string :timestamp
      t.string :app_name
      t.string :pipeline_id
      t.string :pipeline_instance_id
      t.string :sabre_phase
      t.string :task
      t.string :trended_metrics
      t.string :tags

      t.timestamps null: false
    end
  end
end
