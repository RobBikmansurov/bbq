ymaps.ready(init);
var myMap;

function init(){
  map = document.getElementById('map');
  if (map) {
    address = map.getAttribute('data-address');

    myMap = new ymaps.Map("map", {
      center: [58.010450, 56.229434],
      zoom: 10
    });

    myGeocoder = ymaps.geocode(address);

    myGeocoder.then(
      function (res) {
        coordinates = res.geoObjects.get(0).geometry.getCoordinates();

        myMap.geoObjects.add(
          new ymaps.Placemark(
            coordinates,
            {iconContent: address},
            {preset: 'islands#blueStretchyIcon'}
          )
        );

        myMap.setCenter(coordinates);
        myMap.setZoom(15);
      }, function (err) {
        alert('Ошибка при определении местоположения');
      }
    );
  }
}
