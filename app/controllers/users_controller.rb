class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index 
    #THIS IS NOT GOING TO EXIST. GOING TO REDIRECT TO USERS/SHOW
    @users = User.all
    if(current_facebook_user)
      respond_to do |format|
        format.html { }
        format.xml  { render :xml => @users }
      end
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @numbers = Number.where(:user_id => @user.id)
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    if current_user 
      @user = User.find_by_uid(current_user.uid)
    else
      redirect_to root_url, :notice => "Please sign in"
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to(users_community_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(users_community_path, :notice => 'User was successfully updated') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def about
    
  end
  
  #Home page where user logs in with FB
  def home
    
  end
  
  def community
    if current_user
      @name = current_user.name
    end
    @usernumbers = Array.new
    usernumbers = Number.where(:user_id => session[:user_id])
    usernumbers.each do |u| 
      if u.number
        @usernumbers << u.number
      end
    end
  end
  
end



# post = Mogli::Post.new
#     post.message = "Just a message"
#     me = Mogli::User.find("me", current_facebook_client)
#     me.feed_create(post)
