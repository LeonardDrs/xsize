var map;
function initialize() {
  var mapDiv = document.getElementById('map-canvas');
  map = new google.maps.Map(mapDiv, {
    center: new google.maps.LatLng(47.898636, 1.903971),
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  google.maps.event.addListenerOnce(map, 'tilesloaded', addMarkers);

}

function addMarkers() {
    var latLng = new google.maps.LatLng(47.898636, 1.903971);
    var marker = new google.maps.Marker({
      position: latLng,
      map: map
    });
}
      

      google.maps.event.addDomListener(window, 'load', initialize);