// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
// Stats Dashboard //
//function loadGuestStats() {
//  $.get('/invitations/stats', function(data) {
//    $('#invitations-stats-subtotal').html(data.subtotal);
//    $('#invitation-stats-kids').html(data.kids);
//    $('#invitation-stats-grand-total').html(data.grand_total);
//    $('#invitation-stats-invitations').html(data.invitations);
//    $('#invitation-stats-missing-address').html(data.missing_address);
//    $('#invitation-stats-seans-family').html(data.seans_family);
//    $('#invitation-stats-ronnas-family').html(data.ronnas_family);
//    $('#invitation-stats-friends').html(data.friends);
//  });
//}

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
  $('body').on('click', '#address_lookup', function(event) {
    event.preventDefault();
    var personName = $('input#invitation_name').val();
    var invitationCity = $('select#invitation_city').val();
    var invitationState = $('select#invitation_state').val();
    var invitationZip = $('select#invitation_zip').val();
    if (personName.split(' ').length == 2) {
      $.post('/addresses/lookup', {name: personName, state: invitationState, city: invitationCity, zipCode: invitationZip})
    .fail(function() { $('#address_results').prepend('An error occured trying to get address results...').show(); });
    } else {
      $('#address_results').prepend('<p>Enter a first and last name eg: Joe Brown, before we try to look up the address.</p>').show();
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

