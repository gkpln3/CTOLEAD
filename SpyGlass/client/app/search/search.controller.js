'use strict';

angular.module('spyGlassApp')
  .controller('SearchCtrl', function ($scope, $http) {
    $scope.map = { center: { latitude: 32.088950, longitude: 34.783170 }, zoom: 10, control:{} };
    $scope.moment = moment;
    $scope.carNum = '12-348-92';

    $scope.open = function($event) {
      $event.preventDefault();
      $event.stopPropagation();

      $scope.opened = true;
    };

    $scope.minDate = new Date();
    $scope.maxDate = new Date();

    $scope.searchCar = function(carNum) {
      $http.get('/api/cars/' + carNum + '/' + $scope.minDate.toString() + '/' + $scope.maxDate.toString()).success(function (cars) {
        $scope.cars = cars;

      });
    }
  });
