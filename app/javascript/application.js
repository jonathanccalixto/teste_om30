// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import 'vanillajs-datepicker'
import 'vanillajs-datepicker-pt-BR'
import 'inputmask'

document.addEventListener('turbo:load', () => {
  document.querySelectorAll('input.date').forEach((field) => {
    new Datepicker(field, { language: 'pt-BR' });
  });

  document.querySelectorAll('input[data-mask]').forEach((field) => {
    Inputmask(field.dataset.mask).mask(field);
  });
});