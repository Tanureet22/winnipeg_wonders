require("@rails/ujs").start()

import Rails from '@rails/ujs';
Rails.start();
import "@hotwired/turbo-rails"
import "controllers"


import "bootstrap"
import "stylesheets/application"
import 'bootstrap/dist/js/bootstrap.bundle';

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover()
})
