function updateCountdown() {
    var remaining = 400 - $('#composer').val().length;
  $('.countdown').text(remaining);
}

$(document).ready(function($) {
     updateCountdown();
    $('#composer').change(updateCountdown);
  $('#composer').keyup(updateCountdown);
});