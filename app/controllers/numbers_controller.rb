class NumbersController < ApplicationController
  def index
    @numbers = Number.all
    
  end

  def show
    @number = Number.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def edit
    n = params[:id]
    @number = Number.where(:user_id => session[:user_id]).find_by_number(n)

    respond_to do |format|
      format.html 
    end
  end

  def new
    n = params[:format]
    @number = Number.new(:number => n)
  end
  
  def create
    @number = Number.new(params[:number])
    @number.user_id = session[:user_id]
    respond_to do |format|
      if @number.save
        format.html { redirect_to(:action => "show", :id => @number.id, :notice => 'User was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @number = Number.find(params[:id])

    respond_to do |format|
      if @number.update_attributes(params[:number])
        format.html { redirect_to(@number, :notice => 'User was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def picknumber
    @usernumbers = Array.new
    usernumbers = Number.where(:user_id => session[:user_id])
    usernumbers.each do |u| 
      @usernumbers << u.number
    end
  end
  
  
  def search
      query = (params[:search_term].strip == "") ? nil : "%#{params[:search_term].strip}%"
      filter = (params[:filter_term] == "created_at DESC") ? nil : params[:filter_term]
      conditions = query.nil? ? nil : {:name.matches => query} | {:city.matches => query}
      
      @user = current_user
      @org = current_organization
      @orgs = Organization.approved.where(conditions, :type => ["School", "Nonprofit"]).order(filter).includes(:tags) if not filter.nil?
      @orgs = Organization.approved.where(conditions, :type => ["School", "Nonprofit"]).includes(:tags) if filter.nil?
	  render :index
  end
  

end
