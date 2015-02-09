Rails.application.routes.draw do

  root :to =>  'post#index'
  post 'post/create'
  
  get 'post/index'

 
end
