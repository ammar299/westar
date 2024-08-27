class PartsController < ApplicationController
  def index
    @parts = Part.all
  end

  def show
    @part = Part.find(params[:id])
    session[:cart] ||= []
  end

  def add_to_cart
    part_id = params[:id].to_i
    session[:cart] ||= []
    if params[:id].present? && !session[:cart].include?(part_id)
      session[:cart] << part_id 
      cart_count = session[:cart].count
      render json: { status: 'Successfuly added' }
    else
      render json: { status: 'Already added' }
    end
  end

  def new
    @part = Part.new
  end

  def create
    @part = Part.new(part_params)
    if @part.save
      redirect_to @part
    else
      render :new
    end
  end

  def edit
    @part = Part.find(params[:id])
  end

  def update
    @part = Part.find(params[:id])
    if @part.update(part_params)
      redirect_to @part
    else
      render :edit
    end
  end

  def destroy
    @part = Part.find(params[:id])
    @part.destroy
    redirect_to parts_path
  end

  private

  def part_params
    params.require(:part).permit(:item_part_number, :part_number, :name, :description, :package_level_gtin, :height, :width, :length, :shipping_height, :shipping_width, :shipping_length, :weight, :price, :attribute_name, :product_attribute)
  end
end