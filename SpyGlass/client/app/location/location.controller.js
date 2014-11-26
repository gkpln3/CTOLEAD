'use strict';

angular.module('spyGlassApp')
  .controller('LocationCtrl', function ($scope, $http) {
    $http.get('/api/cars/cameras/').success(function (cameras) {
      $scope.cameras = cameras;
      $scope.location = cameras[0];
    });

    $scope.map = { center: { latitude: 32.088950, longitude: 34.783170 }, zoom: 10, control:{} };
    $scope.status = {
      isOpen: false
    }
    $scope.minDate = new Date();
    $scope.maxDate = new Date();

    $scope.searchLocation = function(){
      $http.get('/api/cars/location/'+ $scope.location._id + '/' + $scope.minDate.toString() + '/' + $scope.maxDate.toString()).success(function(cars){
        $scope.cars = cars;
      })
    }
  });
