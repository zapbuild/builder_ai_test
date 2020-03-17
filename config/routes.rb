Rails.application.routes.draw do
  resources :shows
  devise_for :users
  root "shows#index"
  post "/mark_as_favourite/:show_id" => "shows#mark_as_favourite" ,:as=>:show_mark_as_favourite
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
