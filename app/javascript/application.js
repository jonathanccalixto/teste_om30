// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import 'vanillajs-datepicker'

document.addEventListener('turbo:load', () => {
  const form = document.querySelector('.new.municipes,.edit.municipes,.create.municipes,.update.municipes')

  if(!form) return

  const dateField = document.querySelector('input.date');
  const datepicker = new Datepicker(dateField);
});