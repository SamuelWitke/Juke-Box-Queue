# A Router Based Vote to play next song.

What to do on linx 

* Open Spotify App download here https://www.spotify.com/us/download/linux/

* Open new terminal session in same directory and run 	rake jobs:work

* Run rails s 

=======
# Juke-Box-Queue
## How it works 

* Gem Typhoeus to make requests to https://open.spotify.com  link to repo https://github.com/typhoeus/typhoeus

* Gem delayed_job to handle playing songs in separate thread link to repo https://github.com/collectiveidea/delayed_job

* Gem rspotify as a ruby wrapper to the Spotify API link to repo https://github.com/guilhermesad/rspotify 
* Check out lib/SpotifyClient and lib/Player for full details 
=======

