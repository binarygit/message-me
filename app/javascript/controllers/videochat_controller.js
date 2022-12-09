import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="videochat"
export default class extends Controller {
  static targets = ["startButton", "hangupButton", "localVideo", "remoteVideo"];
  connect() {
    this.hangupButtonTarget.disabled = true;
    this.pc;
    this.localStream;

    this.signaling = new BroadcastChannel("webrtc");
    // any data received by the onmessage
    // handler is accessed through e.data
    // this event is provided by BroadcastChannel itself
    this.signaling.onmessage = (e) => {
      if (!this.localStream) {
        console.log("not ready yet");
        return;
      }

      switch (e.data.type) {
        case "offer":
          this.handleOffer(e.data);
          break;
        case "answer":
          this.handleAnswer(e.data);
          break;
        case "candidate":
          this.handleCandidate(e.data);
          break;
        case "ready":
          // A second tab joined. This tab will initiate a call unless in a call already.
          if (this.pc) {
            console.log("already in call, ignoring");
            return;
          }
          this.makeCall();
          break;
      }
    };
  }

  async btnMakeCall() {
    this.localStream = await navigator.mediaDevices.getUserMedia({
      video: true
    });
    this.localVideoTarget.srcObject = this.localStream;

    this.startButtonTarget.disabled = true;
    this.hangupButtonTarget.disabled = true;

    this.signaling.postMessage({ type: "ready" });
  }

  createPeerConnection() {
    this.pc = new RTCPeerConnection();
    this.pc.onicecandidate = (e) => {
      const message = {
        type: "candidate",
        candidate: null,
      };
      if (e.candidate) {
        message.candidate = e.candidate.candidate;
        message.sdpMid = e.candidate.sdpMid;
        message.sdpMLineIndex = e.candidate.sdpMlineIndex;
      }

      this.signaling.postMessage(message);
    };
    this.pc.ontrack = (e) => (this.remoteVideoTarget.srcObject = e.streams[0]);
    this.localStream
      .getTracks()
      .forEach((track) => this.pc.addTrack(track, this.localStream));
  }

  async makeCall() {
    await this.createPeerConnection();

    const offer = await this.pc.createOffer();
    this.signaling.postMessage({ type: "offer", sdp: offer.sdp });
    await this.pc.setLocalDescription(offer);
  }

  async handleOffer(offer) {
    if (this.pc) {
      console.error("existing peerconnection");
      return;
    }

    await this.createPeerConnection();
    await this.pc.setRemoteDescription(offer);

    const answer = await this.pc.createAnswer();

    // postMessage is a function provided by the
    // BroadcastChannel interface
    // postMessage sends the message to any objects
    // listening on the same channel
    this.signaling.postMessage({ type: "answer", sdp: answer.sdp });
    await this.pc.setLocalDescription(answer);
  }

  async handleAnswer(answer) {
    if (!this.pc) {
      console.error("no peerconnection");
      return;
    }
    await this.pc.setRemoteDescription(answer);
  }

  async handleCandidate(candidate) {
    if (!this.pc) {
      console.error("no peerconnection");
      return;
    }

    if (!candidate.candidate) {
      await this.pc.addIceCandidate(null);
    } else {
      await this.pc.addIceCandidate(candidate);
    }
  }
}
