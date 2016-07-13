$(document).on 'page:load ready', ->

  $('.rating-form').raty
    path: '/assets'
    scoreName: 'rate[rating]'

  $('.star-rating').raty
    path: '/assets'
    readOnly: true
    score: ->
      $(this).attr 'data-score'

  $('.rating-form img').click ->
    $(this).closest('form').submit()
