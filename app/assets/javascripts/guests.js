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

  //$('#guest_name').on('blur', function(event) {
  //  var guestName = $('#guest_name').val();
  //  var guestState = $('#guest_state').val();
  //  if (guestName.split(' ').length == 2) {
  //    $.post('/guests/address', {name: guestName, state: guestState}, function(data) {
  //      console.log(data);
  //    });
  //  }
  //});
  
});


