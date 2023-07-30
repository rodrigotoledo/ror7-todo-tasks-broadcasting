import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  destroy(event) {
    if (!confirm("Tem certeza que deseja excluir este item?")) {
      event.preventDefault();
    }
  }
}
