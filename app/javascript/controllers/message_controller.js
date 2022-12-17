import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  connect() {
    super.connect();
  }

  loadMoreMessages() {
    let messages = document.querySelector("#messages");
    let offset = messages.childElementCount;
    this.stimulate("Message#load_more_messages", offset);
  }
}
