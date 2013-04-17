class BlogsController < ApplicationController
  # GET /blogs
  # GET /blogs.json
  
  before_filter :authenticate_user!, :except=> [:index, :show]
  
  def index
  	#in the index, simply don't show drafts. In other views, show drafts if they are yours
    @blogs = Blog.find(:all, :conditions=> "isdraft=0", :order=>"created_at desc") 	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog = Blog.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog }
    end
  end

  # GET /blogs/new
  # GET /blogs/new.json
  def new
    @blog_images=BlogImage.find_all_by_user_id(current_user.id, :limit=>15, :order=> "created_at DESC")

    @blog = Blog.new
    #default published date to right now
    @published=DateTime.now
	@blog.user_id = current_user.id
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blog }
    end
  end

  # GET /blogs/1/edit
  def edit
    @blog = Blog.find(params[:id])
	@blog_images=BlogImage.find_all_by_user_id(current_user.id, :limit=>15, :order=> "created_at DESC")
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(params[:blog])
	if params[:blog_image]
  		@blog.blog_image_id = params[:blog_image].to_i
  	end
	@blog.user_id = current_user.id
	@blog_images=BlogImage.find_all_by_user_id(current_user.id)
	logger.debug "blog_image= "+params[:blog_image].to_s
    respond_to do |format|
      if @blog.save
		if params[:categories]
			#see if they exist, if not create them
			categories = params[:categories].split(",").each {|c| c.strip!}
			categories.each do |c|
				logger.debug "category: "+c
				#look for the category
				@category=Category.find_by_name(c)
				if @category
					logger.debug "category already exists"
					#create association
					@categorization=Categorization.new
					@categorization.category_id=@category.id
					@categorization.blog_id=@blog.id
					@categorization.save
				else
					logger.debug "category doesn't exist - creating"
					@category=Category.new
					@category.name=c
					@category.save
					
					@categorization=Categorization.new
					@categorization.category_id=@category.id
					@categorization.blog_id=@blog.id
					@categorization.save
					#now create the association
				end
			end
		end
		#then add an association
      	
      	#if we got some tags
      	if params[:tags]
			#see if they exist, if not create them
			tags = params[:tags].split(",").each {|t| t.strip!}
			tags.each do |t|
				logger.debug "Tag: "+t
				#look for the tag
				@tag=Tag.find_by_tag(t)
				if @tag
					logger.debug "tag already exists"
					#create association
					@tagged=BlogTag.new
					@tagged.tag_id=@tag.id
					@tagged.blog_id=@blog.id
					@tagged.save
				else
					logger.debug "tag doesn't exist - creating"
					@tag=Tag.new
					@tag.tag=t
					@tag.save
					
					@tagged=BlogTag.new
					@tagged.tag_id=@tag.id
					@tagged.blog_id=@blog.id
					@tagged.save
					#now create the association
				end
			end
			#then add an association
      	end
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render json: @blog, status: :created, location: @blog }
      else
        format.html { render action: "new" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /blogs/1
  # PUT /blogs/1.json
  def update
    @blog = Blog.find(params[:id])
	@blog.user_id = current_user.id
	if params[:blog_image]
  		@blog.blog_image_id = params[:blog_image].to_i
  	end
    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :no_content }
    end
  end
end
