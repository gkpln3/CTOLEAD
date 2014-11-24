'use strict';

angular.module('spyGlassApp')
  .controller('SearchCtrl', function ($scope, $http) {
    $scope.map = { center: { latitude: 32.088950, longitude: 34.783170 }, zoom: 10 };
    $scope.carNum = '12-348-92';
    $scope.searchCar = function(carNum)
    {
      $http.get('/api/cars/' + carNum + '/2014-11-20/2014-11-24').success(function(cars) {
        $scope.cars = cars;
      });
    }
  });
