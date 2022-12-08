import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="remove-element"
export default class extends Controller {
  static values = {
    time: {
      type: Number,
      default: 5000,
    },
  };

  connect() {
    setTimeout(() => {
      this.element.remove();
    }, this.timeValue);
  }
}
