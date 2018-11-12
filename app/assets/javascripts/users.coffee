$('document').ready ->

  addEventToSwithUnsubscribeButtons = (elem, action, display_prefix) ->
    $(elem)[action] ->
       $(this).css('display', 'none')
       id = $(this).attr('id').replace( /^\D+/g, '')
       $("##{display_prefix}_#{id}").css('display', 'inline')

  elementsToHide = $('.btn-following')
  for elem in elementsToHide
    addEventToSwithUnsubscribeButtons(elem, 'mouseenter', 'fd')

  elementsToDisplay = $('.btn-unsubscribe')
  for elem in elementsToDisplay
    addEventToSwithUnsubscribeButtons(elem, 'mouseleave', 'ff')

