# app/jobs/import_parts_job.rb
require 'csv'  # Add this line

class ImportPartsJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    Rails.logger.info("Starting import from #{file_path}")

    # Open the CSV file and process it
    CSV.foreach(file_path, headers: true) do |row|
      # Assuming you have a Part model and the CSV has the correct headers
      Part.create!(row.to_h) # Adjust as necessary based on your CSV headers
    end

    Rails.logger.info("Import completed successfully.")
  rescue StandardError => e
    Rails.logger.error("Import failed: #{e.message}")
  end
end