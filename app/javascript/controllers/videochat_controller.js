import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="videochat"
export default class extends Controller {
  connect() {
    console.log("Hello")
  }
}
