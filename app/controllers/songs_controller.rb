class SongsController < ApplicationController
# Render mobile or desktop depending on User-Agent for these actions.
  before_action :check_for_mobile, :only => [:show, :index, :new, :edit]

  # Always render mobile versions for these, regardless of User-Agent.
#  before_action :prepare_for_mobile, only: [:show, :index]

  before_action :set_song, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /songs
  # GET /songs.json
  def index
	@songs = [] 
	unless Delayed::Job::first.nil?
   	@songs = Song.where.not(job_id: Delayed::Job.first.id).order(:cached_votes_up  => :desc)
	@current = Song.where(job_id: Delayed::Job.first.id).first
	puts @current.inspect
	end
	
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = current_user.songs.build(:track => params[:track], :album => params[:album], :artists => params[:artists], :uri => params[:uri], :url => params[:url])
  end

  # GET /songs/1/edit
  def edit
  end

  def find
	 case @search_opt
        when 'Artist'
            @search_res = RSpotify::Artist.search(@search)
    		@search_res = @search_res.first(5) # Returns the first 5 similar artists
        when 'Album'
            @search_res = RSpotify::Album.search(@search)
    		@search_res = @search_res.first(3) # Returns the first 3 similar albums 
        when 'Track'
            @search_res = RSpotify::Track.search(@search)
    		@search_res = @search_res.first(15) # Returns the first 15 similar track
    end
  end

  def search
	if params[:search].present? 
		@search = params[:search]
		@search_opt = params[:search_opt]
		find
		flash[:error] = "Please give us something to search for!" if !@search_res.present?
	end
  end

  # POST /songs
  # POST /songs.json
  def create
		job=Delayed::Job.enqueue(Schedule::Player.new) #allows delayed_jobs gem to run the background queue of playing songs
		params[:song][:job_id]=job.id
    	@song = current_user.songs.build(song_params)
	respond_to do |format|
      if @song.save
  	    format.html { redirect_to @song, notice: 'Song was successfully created.'+@song.job_id.inspect }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
	@song = set_song
	Delayed::Job.find(@song.job_id).destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def upvote
	@song = set_song
	@song.upvote_by current_user
    redirect_back(fallback_location: root_path)
  end

  def downvote
	@song = set_song
	@song.downvote_from current_user
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:track, :album, :artists, :uri, :url, :job_id)
    end
end
