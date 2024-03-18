# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application'
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'

pin 'bootstrap' # @5.3.3
pin '@popperjs/core', to: 'https://unpkg.com/@popperjs/core@2.11.8/dist/esm/index.js' # @2.11.8
pin 'vanillajs-datepicker', to: 'https://unpkg.com/vanillajs-datepicker@1.3.4/dist/js/datepicker-full.min.js' # @1.3.4
pin 'vanillajs-datepicker-pt-BR', to: 'https://unpkg.com/vanillajs-datepicker@1.3.4/dist/js/locales/pt-BR.js' # @1.3.4
