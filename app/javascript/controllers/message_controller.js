import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  connect() {
    super.connect();
  }

  loadMoreMessages() {
    let offset = document.querySelectorAll("#messages .message").length;
    this.stimulate("Message#load_more_messages", offset);
  }
}
