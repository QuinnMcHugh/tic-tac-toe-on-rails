Rails.application.routes.draw do
	get  '/index', to: 'games#index'
	post '/index', to: 'games#receiveClick'

	root 'games#new'
end
