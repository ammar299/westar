class PartsController < ApplicationController
  def index
    @q = Part.ransack(params[:q])
    @parts = @q.result(distinct: true)
  end

  def search
    @q = Part.ransack(params[:q])
    @parts = @q.result(distinct: true)
    render partial: 'parts/part_list', locals: { parts: @parts }
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

  def import
    uploaded_file = params[:file] # Assuming you have a file input in your form
    file_path = uploaded_file.path

    ImportPartsJob.perform_now(file_path) # Use perform_now instead of perform_later

    flash[:notice] = "Import started successfully."
    redirect_to parts_path
  rescue => e
    flash[:alert] = "Import failed: #{e.message}"
    redirect_to parts_path
  end

  def export
    file_path = Rails.root.join('tmp', 'parts_export.csv').to_s # Convert to string
    ExportPartsJob.perform_later(file_path)

    flash[:notice] = "Export started. The file will be available for download shortly."
    redirect_to parts_path
  end

  def download_export
    file_path = Rails.root.join('tmp', 'parts_export.csv')

    if File.exist?(file_path)
      send_file file_path, type: 'text/csv', filename: 'parts_export.csv'
    else
      flash[:alert] = "Export file not found."
      redirect_to parts_path
    end
  end

  private

  def part_params
    params.require(:part).permit(:item_part_number, :part_number, :name, :description, :package_level_gtin, :height, :width, :length, :shipping_height, :shipping_width, :shipping_length, :weight, :price, :attribute_name, :product_attribute, images: [])
  end
end