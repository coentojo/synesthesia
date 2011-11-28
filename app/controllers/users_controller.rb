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
    if(current_facebook_user) 
       @fbuser = current_facebook_user.fetch
       @name = @fbuser.name
       @email = @fbuser.email
       @age = @fbuser.birthday
       @gender = @fbuser.gender
       @location = Mogli::User.find(current_facebook_user.id, current_facebook_client).location
  
       #check if the logged in user has logged in before
       check = User.find_by_email(@email)
       if check
         redirect_to user_path(check.id)
       else 
         @user = User.new(:name => @name, :email => @email, :age => @age, :gender => @gender, :location => @location)
         respond_to do |format|
           format.html # new.html.erb
         end
       end

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
        format.html { redirect_to(numbers_picknumber_path) }
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
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
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
  
end



# post = Mogli::Post.new
#     post.message = "Just a message"
#     me = Mogli::User.find("me", current_facebook_client)
#     me.feed_create(post)
