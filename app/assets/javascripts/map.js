function initialize() {
  var mapCanvas = document.getElementById('map_canvas');
  var lat = $(mapCanvas).data("coordinates").latitude;
  var long = $(mapCanvas).data("coordinates").longitude;
  var mapOptions = {
    center: new google.maps.LatLng(lat, long),
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(mapCanvas, mapOptions);

  var myRestaurants = $('#map_canvas').data('restaurants');
  for (var i = 0; i < myRestaurants.length; i++) {
    addMarker(myRestaurants[i]);
  }

  function addMarker(restaurant) {
    var lat = restaurant.latitude;
    var long = restaurant.longitude;
    var myLatlng = new google.maps.LatLng(lat, long);

    var marker = new google.maps.Marker({
      position: myLatlng,
      map: map
    });

    var contentString = JST['templates/map_popup_content']({restaurant: restaurant});

    var infowindow = new google.maps.InfoWindow({
      content: contentString
    });

    google.maps.event.addListener(marker, 'click', function () {
      infowindow.open(map, marker);
    });
  }
}

$(document).ready(function () {
  if ($('#map_canvas').length) {
    initialize();
  }

});