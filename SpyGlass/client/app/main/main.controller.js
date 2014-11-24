'use strict';

angular.module('spyGlassApp')
  .controller('MainCtrl', function ($scope, $http, socket) {
    $scope.awesomeThings = [];
    $scope.map = { center: { latitude: 32.088950, longitude: 34.783170 }, zoom: 8 };
    $http.get('/api/alerts').success(function(alerts) {
      $scope.alerts = alerts;
      socket.syncUpdates('alert', $scope.alerts);
      $scope.selectedAlert = alerts[0];
    });

    $scope.deleteAlert = function(alert) {
      $http.delete('/api/alerts/' + alert._id);
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

    $scope.selectAlert= function(alert)
    {
      $scope.selectedAlert = alert;
    }
  });
