class PartsController < ApplicationController
  def index
    @parts = Part.all
  end

  def show
    @part = Part.find(params[:id])
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
    params.require(:part).permit(:item_part_number, :part_number, :description, :package_level_gtin, :height, :width, :length, :shipping_height, :shipping_width, :shipping_length, :weight, :attribute_name, :product_attribute)
  end
end