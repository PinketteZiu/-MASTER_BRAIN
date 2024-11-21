import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {
  connect() {
    flatpickr(this.element)
    document.addEventListener('DOMContentLoaded', function() {
    flatpickr('.flatpickr', {
      mode: "range",
      minDate: "today",
      enableTime: true,
      dateFormat: "Y-m-d H:i",
    });
  });
  }
}
