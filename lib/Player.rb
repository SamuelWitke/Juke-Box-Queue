module Schedule
class Player
  def perform
    raise "current playing" if(Rails.application.config.client.status['playing'])
    @current=Song.order(:cached_votes_up  => :desc).first # Get top up vote
	if(Song.order(:cached_votes_up  => :desc).first != nil) # If page not empty
       	Rails.application.config.client.play(@current.uri) # Play Song
		sleep Rails.application.config.client.status['track']['length'] #Prevent Busy Waiting by Sleeping
       	Song.destroy(@current)# Remove from page
    end
  end
  
  def reschedule_at(current_time, attempts)
    current_time + 5.seconds
  end

  end
end
