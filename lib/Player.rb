module Schedule
class Player

  def perform
	 if(Rails.application.config.client.status['playing'])
        raise "current playing" 
    else
		if(Song.order(:cached_votes_up  => :desc).first != nil) # If page not empty
        	@current=Song.order(:cached_votes_up  => :desc).first # Get top up vote
        	Rails.application.config.client.play(@current.uri) # Play Song
			sleep Rails.application.config.client.status['track']['length'] #Prevent Busy Waiting by Sleeping
        	Song.destroy(@current)# Remove from page
    	end
	end
  end
  
  def reschedule_at(current_time, attempts)
    current_time + 5.seconds
  end
end
end
