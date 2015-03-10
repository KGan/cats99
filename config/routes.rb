Rails.application.routes.draw do
  resources :cats do  # /cats/3/cat_rental_requests
    resources :cat_rental_requests, only: [:index], as: :rental
  end
  resources :cat_rental_requests, except: [:index], as: :rental
  get "cat_rental_requests/:id/approve" => "cat_rental_requests#approve", as: :approve
  get "cat_rental_requests/:id/deny" => "cat_rental_requests#deny", as: :deny
end
