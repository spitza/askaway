$( document ).on( "click", ".logged-out-popover", function() {
    $( this ).popover({ 
    html : true,
  }).popover('toggle');    
    return false;
});
