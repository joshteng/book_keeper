Rails.application.routes.draw do
  resources :books do
    resources :transactions
  end

end
