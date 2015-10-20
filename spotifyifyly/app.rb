require 'sinatra/base'
require 'pry'

require './db/setup'
require './lib/all'

class Spotifyifyly < Sinatra::Base
  enable :sessions

  set :logging, true

  def current_user
    # If you're logged in, return logged in User
    # If not logged in, return nil
    logged_in_user_id = session[:logged_in_user_id]
    User.find_by_id(logged_in_user_id)
  end

  def edit
    @user = current_user
  end

  def update_password
   @user = User.find_by_id(logged_in_user_id)
   if @user.update(user_params)

     sign_in @user, :bypass => true
     redirect_to ("/")

   end

   get "/reset_login" do

 if current_user
   puts "Would you like to change your password?"

   
   update_password

  get "/" do
    if current_user
      "You are #{current_user.email}"
    else
      "It works!"
    end
  end

  get "/login" do
    erb :login
  end

  post "/handle_login" do
    found = User.where(
      email:    params[:email],
      password: params[:password]
    ).first

    if found
      session[:logged_in_user_id] = found.id
      redirect to("/")
    else
      # Show the form again
      @error = "Invalid username or password"
      erb :login
    end
  end

  get "/vote" do
    binding.pry
    #user_id = session[:logged_in_user_id]
    #song_name ==> from params ==> find id

    #Vote.create! user_id: current_user.id, song_id:




  end











 end

  end












end

Spotifyifyly.run!
