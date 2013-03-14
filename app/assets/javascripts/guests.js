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
  $('.need-info').hover(function() {
    $(this).popover('show');
  },
  function() {
    $(this).popover('hide');
  });

  
});


