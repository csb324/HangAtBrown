$(document).ready(function() {

  $('#event_start_time').timepicker({
    'minTime': 'now',
    'scrollDefault': 'now'
  });

  $('#event_end_time').timepicker({
    'minTime': 'now',
    'scrollDefault': 'now'
  });

  $('#rsvp_expected_arrival').timepicker({
    'minTime': 'now',
    'scrollDefault': 'now'
  });

});
