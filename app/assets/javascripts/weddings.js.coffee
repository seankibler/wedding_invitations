jQuery ->
  $('.skip').change ->
    hideContent = $(@).data('hide')
    if $(@).is(':checked')
      $(hideContent).fadeOut()
    else
      $(hideContent).fadeIn()
