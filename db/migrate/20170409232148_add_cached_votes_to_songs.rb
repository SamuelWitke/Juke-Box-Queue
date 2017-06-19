class AddCachedVotesToSongs < ActiveRecord::Migration[5.0]

  def self.down
    remove_column :songs, :cached_votes_total
    remove_column :songs, :cached_votes_score
    remove_column :songs, :cached_votes_up
    remove_column :songs, :cached_votes_down
  end
end
