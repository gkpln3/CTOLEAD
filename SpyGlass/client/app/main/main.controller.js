'use strict';

angular.module('spyGlassApp')
  .controller('MainCtrl', function ($scope, $http, socket) {
    $scope.awesomeThings = [];
    $scope.usualMap = { center: { latitude: 32.088950, longitude: 34.783170 }, zoom: 8, control:{} };
    $scope.excepMap = { center: { latitude: 32.088950, longitude: 34.783170 }, zoom: 8, control:{} };
    $http.get('/api/alerts').success(function(alerts) {
      $scope.alerts = alerts;
      socket.syncUpdates('alert', $scope.alerts);
    });

    $scope.deleteAlert = function(alert) {
      $http.delete('/api/alerts/' + alert._id);
      $scope.selectedAlert = null;
      // Clear the map
      usualDisplay.setDirections({routes:[]});
      excepDisplay.setDirections({routes:[]});
      $scope.mapActive = true;
      $scope.detailsActive = false;
    };

    $scope.pushAlert = function(alert) {
      $http.put('/api/alerts/' + alert._id).success(function(data) {
          alert.pushed = true;
        });
    };

    $scope.$on('$destroy', function () {
      socket.unsyncUpdates('thing');
    });

    $scope.selectAlert= function(alert)
    {
      $http.get('/api/alerts/' + alert._id).success(function(realAlert){
        $scope.selectedAlert = realAlert;
        realAlert.alertPathSource.fixCoord = realAlert.alertPathSource.coordinate.latitude + ',' + realAlert.alertPathSource.coordinate.longitude;
        realAlert.alertPathDest.fixCoord = realAlert.alertPathDest.coordinate.latitude + ',' + realAlert.alertPathDest.coordinate.longitude;
        realAlert.usualPathSource.fixCoord = realAlert.usualPathSource.coordinate.latitude + ',' + realAlert.usualPathSource.coordinate.longitude;
        realAlert.usualPathDest.fixCoord = realAlert.usualPathDest.coordinate.latitude + ',' + realAlert.usualPathDest.coordinate.longitude;
        drawDirections(realAlert.alertPathSource.fixCoord, realAlert.alertPathDest.fixCoord, $scope.excepMap, excepDisplay);
        drawDirections(realAlert.usualPathSource.fixCoord, realAlert.usualPathDest.fixCoord, $scope.usualMap, usualDisplay);
      })
    }

    var excepDisplay = new google.maps.DirectionsRenderer();
    var usualDisplay = new google.maps.DirectionsRenderer();

    function drawDirections(source, destination, map, directionsDisplay)
    {
      directionsDisplay.setMap(map.control.getGMap());
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
