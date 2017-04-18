Rails.application.routes.draw do
  devise_for :users
  resources :songs do
	member do
 		put "like", to:    "songs#upvote"
      	put "dislike", to: "songs#downvote"
		put 'play', to: 'songs#play'
	end
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'songs#index'	
  match "search" => "songs#search",  via: [:get, :post]
end
