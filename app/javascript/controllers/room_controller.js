import ApplicationController from "./application_controller";
import CableReady from "cable_ready";

export default class extends ApplicationController {
  static values = {
    id: Number,
  };

  connect() {
    super.connect();
    this.channel = this.application.consumer.subscriptions.create(
      {
        channel: "RoomsChannel",
        id: this.idValue,
      },
      {
        received(data) {
          if (data.cableReady) CableReady.perform(data.operations);
        },
      }
    );
  }

  disconnect() {
    this.channel.unsubscribe();
  }
}
