class AddJobIdToSongs < ActiveRecord::Migration[5.0]
  def change
    add_column :songs, :job_id, :integer
    add_index :songs, :job_id
  end
end
