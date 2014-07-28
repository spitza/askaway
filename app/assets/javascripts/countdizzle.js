function updateCountdown() {
    var remaining = 500 - $('#composer').val().length;
  $('.countdown').text(remaining);
}

var ready;
ready = function() {
	updateCountdown();
	$('#composer').change(updateCountdown);
	$('#composer').keyup(updateCountdown);
};

$(document).ready(ready);
$(document).on('page:load', ready);

