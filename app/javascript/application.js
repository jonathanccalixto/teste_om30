// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import 'vanillajs-datepicker'
import 'vanillajs-datepicker-pt-BR'

document.addEventListener('turbo:load', () => {
  document.querySelectorAll('input.date').forEach((field) => {
    new Datepicker(field, { language: 'pt-BR' });
  });
});