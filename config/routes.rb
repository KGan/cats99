Rails.application.routes.draw do
  resources :cats do  # /cats/3/cat_rental_requests
    resources :cat_rental_requests, only: [:index, :new], as: :rental
  end
  resources :cat_rental_requests, except: [:index], as: :rental
  get "cat_rental_requests/:id/approve" => "cat_rental_requests#approve", as: :approve
  get "cat_rental_requests/:id/deny" => "cat_rental_requests#deny", as: :deny
  resources :users
  resource :session, only: [:create, :new, :destroy]
  delete "session/log_out_all" => "sessions#log_out_all", as: :log_out_all
  delete "session/:id/log_out" => "sessions#log_out_remote", as: :log_out_remote
end
