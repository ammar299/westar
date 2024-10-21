class BlogsController < ApplicationController
  before_action :set_breadcrumbs

  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @blogs = @category.blogs
    else
      @blogs = Blog.all
    end
  end

  def show
    @blog = Blog.find(params[:id])
    add_breadcrumb @blog.title, blog_path(@blog)
  rescue ActiveRecord::RecordNotFound
    redirect_to blogs_path, alert: 'Blog not found'
  end

  def new
    @blog = Blog.new
    add_breadcrumb 'New Blog', new_blog_path
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to @blog, notice: 'Blog was successfully created.'
    else
      render :new
    end
  end

  def edit
    @blog = Blog.find(params[:id])
    add_breadcrumb 'Edit Blog', edit_blog_path(@blog)
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to @blog, notice: 'Blog was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: 'Blog was successfully deleted.'
  end

  private

  def set_breadcrumbs
    add_breadcrumb 'Home', root_path
    add_breadcrumb 'Blogs', blogs_path

    if action_name == 'show' && @blog.present?
      add_breadcrumb @blog.category.name, category_blogs_path(@blog.category) if @blog.category
    elsif action_name == 'index' && params[:category_id]
      @category = Category.find(params[:category_id])
      add_breadcrumb @category.name, category_blogs_path(@category)
    end
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :category_id, :image)
  end
end