'use strict';

angular.module('spyGlassApp')
  .controller('MainCtrl', function ($scope, $http, socket) {
    $scope.awesomeThings = [];
    $scope.map = { center: { latitude: 32.088950, longitude: 34.783170 }, zoom: 8, control:{} };
    $http.get('/api/alerts').success(function(alerts) {
      $scope.alerts = alerts;
      socket.syncUpdates('alert', $scope.alerts);
      $scope.selectedAlert = alerts[0];
    });

    $scope.deleteAlert = function(alert) {
      $http.delete('/api/alerts/' + alert._id);
    };

    $scope.pushAlert = function(alert) {
      $http.put('/api/alerts/' + alert._id).success(function(data) {
          alert.pushed = true;
        });
    };

    $scope.$on('$destroy', function () {
      socket.unsyncUpdates('thing');
    });

    $scope.next = function() {
      $scope.selectedIndex = Math.min($scope.selectedIndex + 1, 1) ;
    };

    $scope.previous = function() {
      $scope.selectedIndex = Math.max($scope.selectedIndex - 1, 0);
    };

    $scope.selectedIndex = 0;

    var directionsDisplay = new google.maps.DirectionsRenderer();

    $scope.selectAlert= function(alert)
    {
      $scope.selectedAlert = alert;
      alert.alertPathSource.fixCoord = alert.alertPathSource.coordinate.latitude + ',' + alert.alertPathSource.coordinate.longitude;
      alert.alertPathDest.fixCoord = alert.alertPathDest.coordinate.latitude + ',' + alert.alertPathDest.coordinate.longitude;
      drawDirections(alert.alertPathSource.fixCoord, alert.alertPathDest.fixCoord);
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
