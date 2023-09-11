import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Hello World!")
  }

  confirmDelete(e) {
    if (!confirm("Do you realy want to delete this group"))
      e.preventDefault()
  }
}