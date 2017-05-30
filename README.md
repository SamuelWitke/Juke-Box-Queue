# Allows multiple guest to connect and Vote to play next song.

What to do on Linx/Mac

* Open Spotify App download here https://www.spotify.com/us/download/linux/

* Open a terminal session and run rake jobs:work

* Find your IP address for local users to connect to, aka 192.148.123.0

* Open a new terminal and Run rails s -b IP -p 3000


## How it works 

* Gem Typhoeus to make requests to https://open.spotify.com  link to repo https://github.com/typhoeus/typhoeus

* Gem delayed_job to handle playing songs in separate thread link to repo https://github.com/collectiveidea/delayed_job

* Gem rspotify as a ruby wrapper to the Spotify API link to repo https://github.com/guilhermesad/rspotify 
* Check out lib/SpotifyClient and lib/Player for full details 


