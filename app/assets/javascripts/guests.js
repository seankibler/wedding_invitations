// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
// Stats Dashboard //
function loadGuestStats() {
  $.get('/guests/stats', function(data) {
    $('#guest-stats-subtotal').html(data.subtotal);
    $('#guest-stats-kids').html(data.kids);
    $('#guest-stats-guests-guests').html(data.guests_of_guests);
    $('#guest-stats-grand-total').html(data.grand_total);
    $('#guest-stats-invitations').html(data.invitations);
    $('#guest-stats-missing-address').html(data.missing_address);
  });
}

$(document).ready(function() {
  // City typeahead //
  $('input#guest_city').typeahead({
    source: function(query, process) {
      return $.post('/guests/cities', {city: query}, function(data) {
        return process(data);
      });
    },
    minLength: 2
  });

  // Info Popover //
  $('.need-info').popover({html: true, trigger: 'hover', placement: 'top'});

  // Address lookup
  $('body').on('click', '#address_lookup', function(event) {
    event.preventDefault();
    var personName = $('input#guest_name').val();
    var guestCity = $('select#guest_city').val();
    var guestState = $('select#guest_state').val();
    var guestZip = $('select#guest_zip').val();
    if (personName.split(' ').length == 2) {
      $.post('/addresses/lookup', {name: personName, state: guestState, city: guestCity, zipCode: guestZip})
    .fail(function() { $('#address_results').prepend('An error occured trying to get address results...').show(); });
    } else {
      $('#address_results').prepend('<p>Enter a first and last name eg: Joe Brown, before we try to look up the address.</p>').show();
    }
  });

  $('body').on('click', 'tr.address', function(event) {
    $('input#guest_street').val($(this).find('.street').text());
    $('input#guest_city').val($(this).find('.city').text());
    $('input#guest_zip').val($(this).find('.zip').text());
  });

  // Toggle guest notes textarea
  $('body').on('click', '#guest_notes_toggle', function(event) {
    event.preventDefault();
    $('#guest_notes_container').fadeToggle();
  });
});

