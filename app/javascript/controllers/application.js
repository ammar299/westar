import { Application } from "@hotwired/stimulus"

// Start a new Stimulus application
const application = Application.start()

// Configure Stimulus development experience
application.debug = false // Set to true for development
window.Stimulus = application // Expose the application globally

export { application }

console.log("-----------------------------------------------")