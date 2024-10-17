require 'csv'

class ExportPartsJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    Rails.logger.info("Starting export to #{file_path}")

    CSV.open(file_path, 'wb') do |csv|
      csv << ["PartTerminologyName", "Item Part Number", "PartNumber", "Description", "Package Level GTIN", "Height", "Width", "Length", "Shipping Height", "Shipping Width", "Shipping Length", "Weight", "Attribute Name", "Price", "Product Attribute"]
      
      Part.find_each do |part|
        csv << [
          part.name,
          part.item_part_number,
          part.part_number,
          part.description,
          part.package_level_gtin,
          part.height,
          part.width,
          part.length,
          part.shipping_height,
          part.shipping_width,
          part.shipping_length,
          part.weight,
          part.attribute_name,
          part.price,
          part.product_attribute
        ]
      end
    end

    Rails.logger.info("Export completed successfully.")
  rescue StandardError => e
    Rails.logger.error("Export failed: #{e.message}")
  end
end