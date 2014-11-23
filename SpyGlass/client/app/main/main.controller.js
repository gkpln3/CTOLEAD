'use strict';

angular.module('spyGlassApp')
  .controller('MainCtrl', function ($scope, $http, socket) {
    $scope.awesomeThings = [];
    $scope.map = { center: { latitude: 32.088950, longitude: 34.783170 }, zoom: 8 };
    $http.get('/api/alerts').success(function(alerts) {
      $scope.alerts = alerts;
      socket.syncUpdates('alert', $scope.alerts);
    });

    $scope.deleteAlert = function(alert) {
      $http.delete('/api/alerts/' + alert._id);
    };

    $scope.$on('$destroy', function () {
      socket.unsyncUpdates('thing');
    });
  });
