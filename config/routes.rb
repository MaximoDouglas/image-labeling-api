Rails.application.routes.draw do
  resources :images
  
  resources :image_classes do 
    resources :images
  end
  
  resources :domains do 
    resources :image_classes
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
