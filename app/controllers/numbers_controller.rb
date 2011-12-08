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
    @numberlike = Numberlike.where(:user_id => session[:user_id]).find_by_num1(n)
    puts "Numbelie"
    puts @numberlike.to_yaml
    puts session[:user_id]
    puts n
    respond_to do |format|
      format.html 
    end
  end

  def new
    n = params[:format]
    @number = Number.new(:number => n)
    @numberlike = Numberlike.new(:num1 => n)
  end
  
  def create
    @numberlikes = Numberlike.new
    @numberlikes.num1 = params[:number][:number]
    @numberlikes.verb = params[:verb]
    @numberlikes.num2 = params[:num_relation]
    @numberlikes.user_id = session[:user_id];
    @numberlikes.save
    
    @number = Number.new(params[:number])
    @number.user_id = session[:user_id]
    respond_to do |format|
      if @number.save
        format.html { redirect_to(:controller => "users", :action => "community", :notice => 'Number was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @number = Number.find(params[:id])
    @numberlikes = Numberlike.where(:user_id => session[:user_id]).find_by_num1(@number.number)
    @numberlikes.verb = params[:verb]
    @numberlikes.num2 = params[:num_relation]
    @numberlikes.save

    respond_to do |format|
      if @number.update_attributes(params[:number])
        format.html { redirect_to(:controller => "users", :action => "community", :notice => 'Number was successfully updated.') }
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
  
  def archive

  end
  
  def calculateArchive
    nums = [0,1,2,3,4,5,6,7,8,9,10]
    num_words = ["zero","one","two","three","four","five","six","seven","eight","nine","ten"]
    temp = Array.new
    @data = Array.new
    nums.each do |n|
      temp << averageAge(n)
      temp << countColumn(n,"temperment")
      temp << countColumn(n,"color")
      temp << countColumn(n,"gender")
      @data << temp
      temp = Array.new
    end
    render :json => @data
  end

  def averageAge(num)
    n = Number.where(:number => num).average("age") 
    return n.to_i
  end
  
  def countColumn(num, attribute)
    n = 0
    if attribute == "color" 
      types = ["#FF0000", "#FF6600", "#FFFF00", "#33FF33", "#0000FF", "#9900FF", "#FF06F5"]
      type = "#FF0000"
    elsif attribute == "temperment"
      types = ["&#38;", "&#42;", "&#60;", "&#62;", "&#123;", "&#125;", "&#126;", "&#124;", "&#94;", "&#41;", "&#91;"]
      type = "&#38;"
    elsif attribute == "gender"
      types = ["&#36;", "&#33;"]
      type = "&#36;"
    end
    
    types.each do |t| 
      new_n = Number.where(:number => num, attribute => t).count
      if n < new_n
        n = new_n
        type = t
      end
    end
    
    return type
  end
  
  def filtergender
    g = params["g"]
    ["&#36;", "&#33;"]
    not_g = g == "&#36;" ? "&#33;" : "&#36"
    @gen =  g == "&#36;" ? "male" : "female"
    nums = [0,1,2,3,4,5,6,7,8,9,10]
    @data = Array.new
    nums.each do |n| 
      param_gender = Number.where(:number => n, :gender => g).count
      param_gender_not = Number.where(:number => n, :gender => not_g).count
      @data << param_gender if param_gender >= param_gender_not
    end
  end  

end
