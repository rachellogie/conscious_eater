$(document).ready(function() {
  $('select[name=homepage_location]').chosen();


  $( "#format" ).buttonset();

  if (/surprise/.test(window.location.href)) {
    $('body').animate({
      scrollTop: $('#surprise_section').offset().top
    })
  }

  if (/tidbit_edited/.test(window.location.href)) {
    $('body').animate({
      scrollTop: $('.facts').offset().top
    })
  }

});