Rails.application.routes.draw do

  root to: "test_cases#index"

  resources :test_cases do
    resources :executions, :except => [:edit, :update]
  end
end
