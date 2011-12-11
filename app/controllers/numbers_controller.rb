class NumbersController < ApplicationController
  
  def addPadding(n)
    nums = Range.new(0,9)
    if nums.include?(n) 
      return "0"+n.to_s()
    else
      return n.to_s()
    end
  end
  
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
    if session[:user_id]
      @number.user_id = session[:user_id]
    end
    respond_to do |format|
      puts "USERID"
      puts @number.user_id
      if @number.save
        format.html { redirect_to(:controller => "users", :action => "community", :notice => 'Number was successfully created.') }
      else
        format.html { redirect_to(root_path) }
      end
    end
  end
  
  def update
    @number = Number.find(params[:id])
    @numberlikes = Numberlike.where(:user_id => session[:user_id]).find_by_num1(@number.number)
    @numberlikes.verb = params[:verb]
    @numberlikes.num2 = params[:num_relation]

    respond_to do |format|
      if @number.update_attributes(params[:number]) && @numberlikes.save
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
    @logged_user = session[:user_id]

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
    @gen = params["g"] == "&#36;" ? "male" : "female"
    nums = [0,1,2,3,4,5,6,7,8,9,10]
    num_words = ["zero","one","two","three","four","five","six","seven","eight","nine","ten"]
    temp = Array.new
    @data = Array.new
    nums.each do |n|
      temp << averageAge(n)
      temp << countColumn(n,"temperment")
      temp << countColumn(n,"color")
      temp << countColumn(n,"gender")
      temp << n
      @data << temp
      temp = Array.new
    end
    @genders = Array.new
    nums.each do |k|
      if @data[k][3] == params["g"]
        @genders << @data[k]
      end
    end
    render :json => @genders
  end  

  def filterage
    nums = [0,1,2,3,4,5,6,7,8,9,10]
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
    @data.sort! {|a,b| a[0] <=> b[0]}
    render :json => @data
    
  end
  
  def windowage
    @str = params["str"].split(',')
    temp = @str[0]
    @str[0] = addPadding(Integer(temp))
    @n = params["n"]
  end
  
  def filtercolor
    nums = [0,1,2,3,4,5,6,7,8,9,10]
    colors = ["#FF0000", "#FF6600", "#FFFF00", "#33FF33", "#0000FF", "#9900FF", "#FF06F5"]
    
    temp = Array.new
    @data = {}
    nums.each do |n|
      temp << averageAge(n)
      temp << countColumn(n,"temperment")
      temp << countColumn(n,"gender")
      temp << n
      col = countColumn(n, "color") 
      @data[col] ||= []
      @data[col] << temp
      temp = Array.new
    end
    @data.each do |k,v| 
      colors.delete(k) if colors.include? k
    end
    colors.each do |c|
      @data[c] ||= []
    end
    render :json => @data
  end
  
  def windowcolor
    @str = params["str"].split(',')
    @bg = @str[@str.length-1]
    tempStr = Array.new
    tempStr = @str
    tempStr.delete_at(@str.length-1)
    v = 0
    if tempStr.length > 1
      tempStr.each do |y|
        if v%4 == 0 
          tempStr[v] = addPadding(Integer(y))
        end
        v += 1
      end
    end
    
    @numbers = Array.new
    j=0;
    tempStr.each do |w|
      if w.length == 1 || w == '10'
        @numbers << w
        tempStr.delete_at(j)
      end
      j += 1
    end
    @str2 = tempStr
    
    @arr = Array.new
    i = 1
    temp = ""
    @str2.each do |s|
      if i%3 != 0
        temp += s
      else
        temp += s
        @arr << temp
        temp = ""
      end
      i += 1
    end
    @arr
  end
  
  
  def calcmyattributes
    @numbers = Number.where(:user_id => session[:user_id])
    @numbers.sort! {|a,b| a.number <=> b.number}
    render :json => @numbers
  end
  
  def shownum 
    @n = Integer(params["num"]);
    @attributes = params["str"].split(',')
    @equations = Numberlike.where(:num1 => @n)
    
  end
  
  def logout
    reset_session
    redirect_to(root_path)
  end

end




