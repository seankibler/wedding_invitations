// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
// Stats Dashboard //
function loadGuestStats() {
  $.get('/invitations/stats', function(data) {
    $('#stats-kids').html(data.kids);
    $('#stats-total').html(data.guests);
    $('#stats-invitations').html(data.invitations);
    $('#stats-missing-address').html(data.missing_address);
    $('#stats-grooms-family').html(data.grooms_family);
    $('#stats-brides-family').html(data.brides_family);
    $('#stats-friends').html(data.friends);
  });
}

$(document).ready(function() {
  // Clear modal contents on hide
  $('#farmlywed-modal').on('hidden', function() {
    $(this).children('.modal-header h3').empty();
    $(this).children('.modal-body').empty();
    $(this).children('.modal-footer').empty();
  });

  // City typeahead //
  $('input#invitation_city').typeahead({
    source: function(query, process) {
      return $.post('/invitations/cities', {city: query}, function(data) {
        return process(data);
      });
    },
    minLength: 2
  });

  // Info Popover //
  $('.need-info, .help-tip').popover({html: true, trigger: 'hover', placement: 'top'});

  // Address lookup
  $('body').on('click', '.address_lookup', function(event) {
    event.preventDefault();
    $('#address_lookup_error').remove();
    var personInput = $(this).siblings('input[type=text]');
    var personName = personInput.val();
    var invitationCity = $('input#invitation_city').val();
    var invitationState = $('select#invitation_state').val();
    var invitationZip = $('input#invitation_zip').val();
    if (personName.length > 0) {
      $.post('/addresses/lookup', {name: personName, state: invitationState, city: invitationCity, zipCode: invitationZip})
    .fail(function() { personInput.parents('form').prepend('<p id="address_lookup_error">An error occured trying to get address results...</p>'); });
    } else {
      $(this).siblings('input[type=text]').css('background-color', '#ee4');
      $(this).parents('form').prepend('<p id="address_lookup_error">We\'re not magicians, we need a name :)</p>').show();
    }
  });

  $('body').on('click', 'tr.address', function(event) {
    $('input#invitation_street').val($(this).find('.street').text());
    $('input#invitation_city').val($(this).find('.city').text());
    $('input#invitation_zip').val($(this).find('.zip').text());
  });

  // Toggle invitation notes textarea
  $('body').on('click', '#invitation_notes_toggle', function(event) {
    event.preventDefault();
    $('#invitation_notes_container').fadeToggle();
  });
});

