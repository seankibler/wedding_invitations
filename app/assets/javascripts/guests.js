// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
$(document).ready(function() {
  $('input#guest_city').typeahead({
    source: function(query, process) {
      return $.post('/guests/cities', {city: query}, function(data) {
        return process(data);
      });
    },
    minLength: 2
  });

  $('.need-info').hover(function() {
    $(this).popover('show');
  },
  function() {
    $(this).popover('hide');
  });
});


