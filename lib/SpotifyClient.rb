=begin
	Largely inspired by Spotilocal
	Spotilocal allows you to query the local spotify client and fetch 
	informations about the current status and perform 
	actions such as start/stop.
	https://github.com/Flipez/spotilocal
=end
module SpotifyClient
class Client
    attr_accessor :port, :csrf, :url, :oauth

    HEADERS = { Origin: 'https://open.spotify.com' }.freeze

    def initialize(port: discover_port)
      raise 'Port required' unless port
      @url = "http://localhost:#{port}"
	  @csrf = csrf_token 
      @oauth = oauth_token
    end

    def status
      lcall(:status)
    end

    def current
      current = {}
      current['track'] = track_from_status status
      current['album'] = album_from_status status
      current['artist'] = artist_from_status status

      current
    end
	
    def play(uri)
      r = lcall(:play, params: { uri: uri })
      r['playing'] && r['track']['track_resource']['uri'] == uri
    end

    def pause
      !lcall(:pause, params: { pause: 'true' })['playing']
    end

    def unpause
      lcall(:pause, params: { pause: 'false' })['playing']
    end


    private

    def lcall(loc, params: {}, resource: :remote)
      req = Typhoeus.get("#{url}/#{resource}/#{loc}.json",
                         params: params.merge(csrf: csrf, oauth: oauth))
      JSON.parse(req.response_body) if req.response_body.is_a?(String) && req.response_body.length >= 2
    end

    def oauth_token
      req = Typhoeus.get('http://open.spotify.com/token', followlocation: true)
      JSON.parse(req.response_body)['t'] rescue ''#if req.response_body.is_a?(String) && req.response_body.length >= 2
   end


    def csrf_token
      req = Typhoeus.get("#{url}/simplecsrf/token.json", headers: HEADERS)
      JSON.parse(req.response_body)['token'] if req.response_body.is_a?(String) && req.response_body.length >= 2

    end

    def discover_port
      (4370..4390).each do |port|
        if Typhoeus.get("http://localhost:#{port}",
                        timeout: 1).return_code == :ok
          return port
        end
      end
    end

  end
end

