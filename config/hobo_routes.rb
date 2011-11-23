# This is an auto-generated file: don't edit!
# You can add your own routes in the config/routes.rb file
# which will override the routes in this file.

MagicDispatcher::Application.routes.draw do


  # Lifecycle routes for controller "users"
  post 'users/signup(.:format)' => 'users#do_signup', :as => 'do_user_signup'
  get 'users/signup(.:format)' => 'users#signup', :as => 'user_signup'
  put 'users/:id/reset_password(.:format)' => 'users#do_reset_password', :as => 'do_user_reset_password'
  get 'users/:id/reset_password(.:format)' => 'users#reset_password', :as => 'user_reset_password'

  # Resource routes for controller "users"
  get 'users(.:format)' => 'users#index', :as => 'users'
  get 'users/new(.:format)', :as => 'new_user'
  get 'users/:id/edit(.:format)' => 'users#edit', :as => 'edit_user'
  get 'users/:id(.:format)' => 'users#show', :as => 'user', :constraints => { :id => %r([^/.?]+) }
  post 'users(.:format)' => 'users#create', :as => 'create_user'
  put 'users/:id(.:format)' => 'users#update', :as => 'update_user', :constraints => { :id => %r([^/.?]+) }
  delete 'users/:id(.:format)' => 'users#destroy', :as => 'destroy_user', :constraints => { :id => %r([^/.?]+) }

  # Show action routes for controller "users"
  get 'users/:id/account(.:format)' => 'users#account', :as => 'user_account'

  # User routes for controller "users"
  match 'login(.:format)' => 'users#login', :as => 'user_login'
  get 'logout(.:format)' => 'users#logout', :as => 'user_logout'
  match 'forgot_password(.:format)' => 'users#forgot_password', :as => 'user_forgot_password'


  # Resource routes for controller "sections"
  get 'sections(.:format)' => 'sections#index', :as => 'sections'
  get 'sections/new(.:format)', :as => 'new_section'
  get 'sections/:id/edit(.:format)' => 'sections#edit', :as => 'edit_section'
  get 'sections/:id(.:format)' => 'sections#show', :as => 'section', :constraints => { :id => %r([^/.?]+) }
  post 'sections(.:format)' => 'sections#create', :as => 'create_section'
  put 'sections/:id(.:format)' => 'sections#update', :as => 'update_section', :constraints => { :id => %r([^/.?]+) }
  delete 'sections/:id(.:format)' => 'sections#destroy', :as => 'destroy_section', :constraints => { :id => %r([^/.?]+) }


  # Resource routes for controller "railroads"
  get 'railroads(.:format)' => 'railroads#index', :as => 'railroads'
  get 'railroads/new(.:format)', :as => 'new_railroad'
  get 'railroads/:id/edit(.:format)' => 'railroads#edit', :as => 'edit_railroad'
  get 'railroads/:id(.:format)' => 'railroads#show', :as => 'railroad', :constraints => { :id => %r([^/.?]+) }
  post 'railroads(.:format)' => 'railroads#create', :as => 'create_railroad'
  put 'railroads/:id(.:format)' => 'railroads#update', :as => 'update_railroad', :constraints => { :id => %r([^/.?]+) }
  delete 'railroads/:id(.:format)' => 'railroads#destroy', :as => 'destroy_railroad', :constraints => { :id => %r([^/.?]+) }


  # Resource routes for controller "branches"
  get 'branches(.:format)' => 'branches#index', :as => 'branches'
  get 'branches/new(.:format)', :as => 'new_branch'
  get 'branches/:id/edit(.:format)' => 'branches#edit', :as => 'edit_branch'
  get 'branches/:id(.:format)' => 'branches#show', :as => 'branch', :constraints => { :id => %r([^/.?]+) }
  post 'branches(.:format)' => 'branches#create', :as => 'create_branch'
  put 'branches/:id(.:format)' => 'branches#update', :as => 'update_branch', :constraints => { :id => %r([^/.?]+) }
  delete 'branches/:id(.:format)' => 'branches#destroy', :as => 'destroy_branch', :constraints => { :id => %r([^/.?]+) }


  # Resource routes for controller "tracks"
  get 'tracks(.:format)' => 'tracks#index', :as => 'tracks'
  get 'tracks/new(.:format)', :as => 'new_track'
  get 'tracks/:id/edit(.:format)' => 'tracks#edit', :as => 'edit_track'
  get 'tracks/:id(.:format)' => 'tracks#show', :as => 'track', :constraints => { :id => %r([^/.?]+) }
  post 'tracks(.:format)' => 'tracks#create', :as => 'create_track'
  put 'tracks/:id(.:format)' => 'tracks#update', :as => 'update_track', :constraints => { :id => %r([^/.?]+) }
  delete 'tracks/:id(.:format)' => 'tracks#destroy', :as => 'destroy_track', :constraints => { :id => %r([^/.?]+) }

  namespace :admin do


    # Resource routes for controller "admin/track_types"
    get 'track_types(.:format)' => 'track_types#index', :as => 'track_types'
    get 'track_types/new(.:format)', :as => 'new_track_type'
    get 'track_types/:id/edit(.:format)' => 'track_types#edit', :as => 'edit_track_type'
    get 'track_types/:id(.:format)' => 'track_types#show', :as => 'track_type', :constraints => { :id => %r([^/.?]+) }
    post 'track_types(.:format)' => 'track_types#create', :as => 'create_track_type'
    put 'track_types/:id(.:format)' => 'track_types#update', :as => 'update_track_type', :constraints => { :id => %r([^/.?]+) }
    delete 'track_types/:id(.:format)' => 'track_types#destroy', :as => 'destroy_track_type', :constraints => { :id => %r([^/.?]+) }


    # Resource routes for controller "admin/users"
    get 'users(.:format)' => 'users#index', :as => 'users'
    get 'users/new(.:format)', :as => 'new_user'
    get 'users/:id/edit(.:format)' => 'users#edit', :as => 'edit_user'
    get 'users/:id(.:format)' => 'users#show', :as => 'user', :constraints => { :id => %r([^/.?]+) }
    post 'users(.:format)' => 'users#create', :as => 'create_user'
    put 'users/:id(.:format)' => 'users#update', :as => 'update_user', :constraints => { :id => %r([^/.?]+) }
    delete 'users/:id(.:format)' => 'users#destroy', :as => 'destroy_user', :constraints => { :id => %r([^/.?]+) }


    # Resource routes for controller "admin/track_connections"
    get 'track_connections(.:format)' => 'track_connections#index', :as => 'track_connections'
    get 'track_connections/new(.:format)', :as => 'new_track_connection'
    get 'track_connections/:id/edit(.:format)' => 'track_connections#edit', :as => 'edit_track_connection'
    get 'track_connections/:id(.:format)' => 'track_connections#show', :as => 'track_connection', :constraints => { :id => %r([^/.?]+) }
    post 'track_connections(.:format)' => 'track_connections#create', :as => 'create_track_connection'
    put 'track_connections/:id(.:format)' => 'track_connections#update', :as => 'update_track_connection', :constraints => { :id => %r([^/.?]+) }
    delete 'track_connections/:id(.:format)' => 'track_connections#destroy', :as => 'destroy_track_connection', :constraints => { :id => %r([^/.?]+) }


    # Resource routes for controller "admin/roles"
    get 'roles(.:format)' => 'roles#index', :as => 'roles'
    get 'roles/new(.:format)', :as => 'new_role'
    get 'roles/:id/edit(.:format)' => 'roles#edit', :as => 'edit_role'
    get 'roles/:id(.:format)' => 'roles#show', :as => 'role', :constraints => { :id => %r([^/.?]+) }
    post 'roles(.:format)' => 'roles#create', :as => 'create_role'
    put 'roles/:id(.:format)' => 'roles#update', :as => 'update_role', :constraints => { :id => %r([^/.?]+) }
    delete 'roles/:id(.:format)' => 'roles#destroy', :as => 'destroy_role', :constraints => { :id => %r([^/.?]+) }


    # Resource routes for controller "admin/permissions"
    get 'permissions(.:format)' => 'permissions#index', :as => 'permissions'
    get 'permissions/new(.:format)', :as => 'new_permission'
    get 'permissions/:id/edit(.:format)' => 'permissions#edit', :as => 'edit_permission'
    get 'permissions/:id(.:format)' => 'permissions#show', :as => 'permission', :constraints => { :id => %r([^/.?]+) }
    post 'permissions(.:format)' => 'permissions#create', :as => 'create_permission'
    put 'permissions/:id(.:format)' => 'permissions#update', :as => 'update_permission', :constraints => { :id => %r([^/.?]+) }
    delete 'permissions/:id(.:format)' => 'permissions#destroy', :as => 'destroy_permission', :constraints => { :id => %r([^/.?]+) }

  end

end
