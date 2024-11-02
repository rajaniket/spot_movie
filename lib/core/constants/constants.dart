class SharedPreferencesKeys {
  static const String cachedMovies = 'cached_movies';
  static const String cacheTime = 'cache_time';
}

class MapConstants {
  static const String mapStyle = '''
[
   {
      "featureType": "administrative",
      "elementType": "geometry.fill",
      "stylers": [
         {
            "color": "#d6e2e6"
         }
      ]
   },
   {
      "featureType": "administrative",
      "elementType": "geometry.stroke",
      "stylers": [
         {
            "color": "#cfd4d5"
         }
      ]
   },
   {
      "featureType": "administrative",
      "elementType": "labels.text.fill",
      "stylers": [
          {
              "saturation": 36
          },
          {
              "color": "#000000"
          },
          {
              "lightness": 40
          }
      ]
   },
   {
      "featureType": "administrative.neighborhood",
      "elementType": "labels.text.fill",
      "stylers": [
         {
            "lightness": 25
         }
      ]
   },
   {
      "featureType": "landscape",
      "elementType": "geometry",
      "stylers": [
         {
            "color": "#000000"
         },
         {
            "lightness": 2
         }
      ]
   },
   {
      "featureType": "poi",
      "elementType": "labels.icon",
      "stylers": [
         {
            "saturation": -100
         }
      ]
   },
   {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#000000"
            },
            {
                "lightness": 16
            }
      ]
   },
   {
      "featureType": "poi.park",
      "elementType": "geometry.fill",
      "stylers": [
         {
            "color": "#a9de83"
         }
      ]
   },
   {
      "featureType": "poi.park",
      "elementType": "geometry.stroke",
      "stylers": [
         {
            "color": "#bae6a1"
         }
      ]
   },
   {
      "featureType": "poi.sports_complex",
      "elementType": "geometry.fill",
      "stylers": [
         {
            "color": "#c6e8b3"
         }
      ]
   },
   {
      "featureType": "poi.sports_complex",
      "elementType": "geometry.stroke",
      "stylers": [
         {
            "color": "#bae6a1"
         }
      ]
   },
   {
      "featureType": "road",
      "elementType": "labels.icon",
      "stylers": [
         {
            "saturation": -45
         },
         {
            "lightness": 10
         },
         {
            "visibility": "on"
         }
      ]
   },
   {
      "featureType": "road",
      "elementType": "labels.text.fill",
      "stylers": [
         {
            "color": "#41626b"
         }
      ]
   },
   {
      "featureType": "road.highway",
      "elementType": "geometry.fill",
      "stylers": [
         {
            "color": "#000000"
         },
         {
            "lightness": 17
         }
      ]
   },
   {
      "featureType": "road.highway",
      "elementType": "geometry.stroke",
      "stylers": [
         {
            "color": "#000000"
         },
         {
            "lightness": 29
         },
         {
            "weight": 0.2
         }
      ]
   },
   {
      "featureType": "road.arterial",
      "elementType": "geometry",
      "stylers": [
         {
            "color": "#000000"
         },
         {
            "lightness": 18
         }
      ]
   },
   {
      "featureType": "road.local",
      "elementType": "geometry",
      "stylers": [
         {
            "color": "#000000"
         },
         {
            "lightness": 16
         }
      ]
   },
   {
      "featureType": "transit",
      "elementType": "geometry",
      "stylers": [
         {
            "color": "#000000"
         },
         {
            "lightness": 19
         }
      ]
   },
   {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [
         {
            "color": "#000000"
         },
         {
            "lightness": 17
         }
      ]
   }
]''';
}
