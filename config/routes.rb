Rails.application.routes.draw do

# 设定下述路由后，得到的URL地址应该是类似/users/1/following 和 /users/1/followers这种形式，因为这两个页面都是用来显示数据的，我们用了get方法，指定这两个地址响应的是GET请求
# 路由设置中使用的member方法作用是，设置这两个动作对应的URL地址中应该包含用户的id.类似的，我们还可以使用collection方法，但URL中就没要用户id了
  resources :users do
    member do
      get :following, :followers
    end
  end
  # resources :users do 
  #   collection do
  #     get :tigers
  #   end
  # end
  resources :sessions, only:[:new, :create, :destroy]
  resources :microposts, only:[:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  root to: 'static_pages#home'
  match '/signup', to: 'users#new', 			via: 'get'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', 	via: 'delete'
  match '/bdel', to: 'users#destroy_multiple',   via: 'delete'
  match '/bdel', to: 'users#bdel',   via: 'get'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
