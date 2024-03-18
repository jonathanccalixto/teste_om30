// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import 'vanillajs-datepicker'

document.addEventListener('turbo:load', () => {
  document.querySelectorAll('input.date').forEach((dateField) => {
    new Datepicker(dateField);
  });
});