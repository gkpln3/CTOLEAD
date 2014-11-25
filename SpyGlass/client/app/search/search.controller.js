'use strict';

angular.module('spyGlassApp')
  .controller('SearchCtrl', function ($scope, $http) {
    $scope.map = { center: { latitude: 32.088950, longitude: 34.783170 }, zoom: 10, control:{} };
    $scope.moment = moment;
    $scope.carNum = '12-348-92';

    var directionsDisplay = new google.maps.DirectionsRenderer();

    $scope.searchCar = function(carNum)
    {
      $http.get('/api/cars/' + carNum + '/2014-11-20/2014-11-24').success(function(cars) {
        $scope.cars = cars;
        $scope.cars.forEach(function(car){
          car.camId.fixCoord = car.camId.coordinate.latitude + ',' + car.camId.coordinate.longitude;
        });

        for(var i=0; i< cars.length-1;i++) {
          console.log(cars[i].camId.fixCoord);
          console.log(cars[i+1].camId.fixCoord);
          drawDirections(cars[i].camId.fixCoord, cars[i+1].camId.fixCoord);
        }
        });
    }

    function drawDirections(source, destination)
    {
      directionsDisplay.setMap($scope.map.control.getGMap());
      var directionsService = new google.maps.DirectionsService();

      var request = {
        origin: source,
        destination: destination,
        travelMode: google.maps.TravelMode.DRIVING
      };
      directionsService.route(request, function(response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
          directionsDisplay.setDirections(response);
        }
      });
    }
  });
