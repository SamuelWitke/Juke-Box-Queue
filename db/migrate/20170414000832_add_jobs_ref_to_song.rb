class AddJobsRefToSong < ActiveRecord::Migration[5.0]
  def change
    add_reference :songs, :delayed_jobs, index: true
  end
end
