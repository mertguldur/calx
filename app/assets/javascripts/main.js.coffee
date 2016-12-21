$(document).on 'turbolinks:load', ->
  $("#calendar-datepicker-input").datepicker().on 'changeDate', (e) ->
    $(this).datepicker('hide')
    day = e.date.getDate()
    month = e.date.getMonth() + 1
    year = e.date.getFullYear()
    date = year + '-' + month + '-' + day
    $("#hidden-date-change-button").attr("href", "/events?date=" + date)
    $("#hidden-date-change-button")[0].click()
