/**
 * Populate DB with sample data on server start
 * to disable, edit config/environment/index.js, and set `seedDB: false`
 */

'use strict';

var Thing = require('../api/thing/thing.model');
var User = require('../api/user/user.model');
var Car = require('../api/car/car.model');
var Camera = require('../api/camera/camera.model');
var Alert = require('../api/alert/alert.model');

Thing.find({}).remove(function() {
  Thing.create({
    name : 'Development Tools',
    info : 'Integration with popular tools such as Bower, Grunt, Karma, Mocha, JSHint, Node Inspector, Livereload, Protractor, Jade, Stylus, Sass, CoffeeScript, and Less.'
  }, {
    name : 'Server and Client integration',
    info : 'Built with a powerful and fun stack: MongoDB, Express, AngularJS, and Node.'
  }, {
    name : 'Smart Build System',
    info : 'Build system ignores `spec` files, allowing you to keep tests alongside code. Automatic injection of scripts and styles into your index.html'
  },  {
    name : 'Modular Structure',
    info : 'Best practice client and server structures allow for more code reusability and maximum scalability'
  },  {
    name : 'Optimized Build',
    info : 'Build process packs up your templates as a single JavaScript payload, minifies your scripts/css/images, and rewrites asset names for caching.'
  },{
    name : 'Deployment Ready',
    info : 'Easily deploy your app to Heroku or Openshift with the heroku and openshift subgenerators'
  });
});

User.find({}).remove(function() {
  User.create({
    provider: 'local',
    name: 'Test User',
    email: 'test@test.com',
    password: 'test'
  }, {
    provider: 'local',
    role: 'admin',
    name: 'Admin',
    email: 'admin@admin.com',
    password: 'admin'
  }, function() {
      console.log('finished populating users');
    }
  );
});

var logger = function(message){console.log(message)};

Car.find({}).remove(function() {
    Car.create({
      carId: "12-348-92",
      color: "Blue",
      suspicious: true,
      camId: 1,
      date: new Date(2014,10,23)},
      {
        carId: "12-348-92",
        color: "Blue",
        suspicious: true,
        camId: 2,
        date: new Date(2014,10,22)
      },
      {
        carId: "12-348-92",
        color: "Blue",
        suspicious: true,
        camId: 3,
        date: new Date(2014,10,21)
      },
      {
        carId: "12-348-93",
        color: "Red",
        suspicious: true,
        camId: 1,
        date: new Date(2014,10,22)
      },
      {
        carId: "12-348-93",
        color: "Red",
        suspicious: true,
        camId: 2,
        date: new Date(2014,10,22)
      },
      function() { console.log("Done creating cars")});
  });

Camera.find({}).remove(function() {
  Camera.create({
      _id:1,
      location: 'Tel Aviv',
      coordinate:{latitude: 32.082723, longitude: 34.794685}
    }, {
      _id:2,
      location: 'Holon',
      coordinate:{latitude: 32.022555, longitude: 34.778967}
    }, {
      _id:3,
      location: 'Petah Tikva',
      coordinate:{latitude: 32.093148, longitude: 34.866696}
    }, function() {
      console.log('finished populating cameras');
    }
  );
});

Alert.find({}).remove(function() {
  Alert.create({
      carId:"12-348-92",
      date: new Date(2014,10,23),
      alertPathSource:1,
      alertPathDest:2,
      percentage: 3
    }, {
      carId:"12-348-93",
      date: new Date(2014,10,22),
      alertPathSource:1,
      alertPathDest:3,
      percentage: 5
    }, function() {
      console.log('finished populating alerts');
    }
  );
});


