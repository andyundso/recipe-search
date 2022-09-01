import {Controller} from "@hotwired/stimulus"
import TomSelect from "tom-select";

export default class extends Controller {
  connect() {
    const selectElements = this.element.querySelectorAll("select");

    selectElements.forEach((select) => {
      new TomSelect(select, {...(select.multiple && {plugins: ["remove_button"]})});
    })
  }
}
