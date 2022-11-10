import ApplicationController from './application_controller'
export default class extends ApplicationController {
  static targets = ["submit", "input"]
  connect () {
    super.connect()
  }

  beforeCreate() {
    this.submitTarget.disabled = true
  }

  afterCreate() {
    this.submitTarget.disabled = false
    this.inputTarget.focus()
  }

  createSuccess() {
    this.element.reset()
  }
}
