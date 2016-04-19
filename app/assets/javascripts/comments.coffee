#$(document).on "page:change", -> #if turbolinks selected else..
$(document).ready ->
  $('#comments-link').click (event) ->
    event.preventDefault()  
    #alert "Clicked!" #for testing purpose only
    $('#comments-section').fadeToggle()