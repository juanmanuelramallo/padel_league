// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "chartkick"
import Highcharts from "highcharts"
import Alpine from 'alpinejs'

window.Alpine = Alpine
window.Highcharts = Highcharts

Alpine.start()
