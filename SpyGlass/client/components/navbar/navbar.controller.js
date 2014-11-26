'use strict';

angular.module('spyGlassApp')
  .controller('NavbarCtrl', function ($scope, $location, Auth) {
    $scope.menu = [{
      'title': 'התראות',
      'link': '/'
    },
      {
        title: 'חיפוש לפי מספר',
        link: '/search'
      },
      {
        title: 'חיפוש לפי מיקום',
        link: '/location'
      }];

    $scope.isCollapsed = true;
    $scope.isLoggedIn = Auth.isLoggedIn;
    $scope.isAdmin = Auth.isAdmin;
    $scope.getCurrentUser = Auth.getCurrentUser;

    $scope.logout = function() {
      Auth.logout();
      $location.path('/login');
    };

    $scope.isActive = function(route) {
      return route === $location.path();
    };
  });
