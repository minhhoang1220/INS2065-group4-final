import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "input", "messages"]

  connect() {
    this.scrollToBottom()
  }

  scrollToBottom() {
    if (this.hasMessagesTarget) {
      this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
    }
  }

  submit(event) {
    event.preventDefault()
    if (this.inputTarget.value.trim() === '') return

    const form = this.formTarget
    const formData = new FormData(form)

    fetch(form.action, {
      method: 'POST',
      body: formData,
      headers: {
        'Accept': 'text/html',
        'X-Requested-With': 'XMLHttpRequest'
      },
      credentials: 'same-origin'
    })
    .then(response => response.text())
    .then(html => {
      this.messagesTarget.insertAdjacentHTML('beforeend', html)
      this.inputTarget.value = ''
      this.scrollToBottom()
    })
  }
} 