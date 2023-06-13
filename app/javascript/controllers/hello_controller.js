import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  static targets = ["inputDate"]

  connect() {
    flatpickr(this.inputDateTarget, {
      enableTime: true,
      minDate: "today",
      altInput: true,
      altFormat: "Y F j H:i",
      locale: 'ja',
      dateFormat: 'Y/m/d(D) H:i',
    });
  }
}
