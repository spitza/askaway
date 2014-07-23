$( document ).on( "click", ".vote-button-logged-out", function() {
    $( this ).popover({ 
    html : true,
  }).popover('toggle');    
    return false;
});
