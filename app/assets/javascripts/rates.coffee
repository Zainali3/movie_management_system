# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
set_average = (avg) ->
  $('.avg-star-rating').raty 'set', score: avg

$(document).on 'ready page:load', ->
  $('.rating').raty
    path: '/assets'
    readOnly: true
    score: ->
      $(this).attr 'data-score'
  $('.rating-form').raty
    path: '/assets'
    scoreName: 'rate[rating]'
  $('.avg-star-rating').raty
    path: '/assets/'
    readOnly: true
    score: ->
      $(this).attr 'data-score'
  $('.star-rating').raty
    path: '/assets/'
    score: ->
      $(this).attr 'data-score'
    click: (score, evt) ->
      movie_id = $('#movie-container').data('movie')
      id = $('#movie-container').data('rating')
      if id == ''
        $.ajax
          type: 'POST'
          url: '/movies/' + movie_id + '/rates'
          data: rate:
            movie_id: movie_id
            rating: score
          dataType: 'json'
          success: (data) ->
            set_average(data.average)
            $('#movie-container').data 'rating', data.id
      else
        $.ajax
          type: 'PATCH'
          url: '/movies/' + movie_id + '/rates/' + id
          data: rate:
            movie_id: movie_id
            rating: score
          dataType: 'json'
          success: (data) ->
            set_average(data.average)
