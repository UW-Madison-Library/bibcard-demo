//
// Load Linked Data
//

// Fetches inner html content for a given bibcard entry.
function load_bib_cards() {
  $('.bib-card').each(function() {

    // Load in data via ajax
    $(this).load("/authors/" + $(this).data('lcnaf'), function(body, status, xhr) {
      if (status == "success") {
        if (body.length < 0) $(this).html("Nothing found");
      } else {
        $(this).html("Error looking up data");
      }
    });
  });
}

$(document).ready(function() {

  load_bib_cards();

});
