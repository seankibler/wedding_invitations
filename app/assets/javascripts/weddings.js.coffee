jQuery ->
  $('.skip').change ->
    hideContent = $(@).data('hide')
    if $(@).is(':checked')
      $(hideContent).fadeOut()
    else
      $(hideContent).fadeIn()
  $('#wedding_wedding_date').datepicker({
    dateFormat: 'MM d, yy'
  })
