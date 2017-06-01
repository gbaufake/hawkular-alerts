# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('[data-toggle="tooltip"]').tooltip()
  $('.alert').fadeTo(2000, 500).slideUp 500, ->
    $('.alert').slideUp 500
  $('pre code').each (i, block) ->
    hljs.highlightBlock block
  return
