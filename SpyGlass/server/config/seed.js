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
var Person = require('../api/person/person.model');

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
    Car.create(
      {
        carId: "12-348-92",
        color: "Blue",
        suspicious: true,
        camId: 1,
        date: new Date(2014,10,23)
      },
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
      { carId : "12-348-92", color : "Blue", suspicious : true, camId : 1, date : new Date(2014,11,28) },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 2, "date" : new Date("2014-11-28") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 1, "date" : new Date("2014-11-29") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 2, "date" : new Date("2014-11-29") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 1, "date" : new Date("2014-11-30") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 2, "date" : new Date("2014-11-30") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 1, "date" : new Date("2014-11-01") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 2, "date" : new Date("2014-11-01") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 1, "date" : new Date("2014-11-02") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 2, "date" : new Date("2014-11-02") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 1, "date" : new Date("2014-11-03") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 2, "date" : new Date("2014-11-03") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 3, "date" : new Date("2014-11-05") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 4, "date" : new Date("2014-11-05") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 1, "date" : new Date("2014-11-06") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 2, "date" : new Date("2014-11-06") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 1, "date" : new Date("2014-11-07") },
      { "carId" : "12-348-92", "color" : "Blue", "suspicious" : true, "camId" : 2, "date" : new Date("2014-11-07") },
      function() { console.log("Done creating cars")});
  });

Camera.find({}).remove(function() {
  Camera.create({
      _id:1,
      location: 'תל אביב',
      coordinate:{latitude: 32.082723, longitude: 34.794685}
    }, {
      _id:2,
      location: 'חולון',
      coordinate:{latitude: 32.022555, longitude: 34.778967}
    }, {
      _id:3,
      location: 'פתח תקווה',
      coordinate:{latitude: 32.093148, longitude: 34.866696}
    }, {
      _id:4,
      location: 'ירושלים',
      coordinate:{latitude: 31.780600, longitude: 35.207711}
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
      usualPathSource:1,
      usualPathDest:3,
      usualPercentage:92,
      percentage: 3
    }, {
      carId:"12-348-93",
      date: new Date(2014,10,22),
      alertPathSource:1,
      alertPathDest:3,
      usualPathSource:1,
      usualPathDest:2,
      usualPercentage:90,
      percentage: 5
    },
  function() {
      console.log('finished populating alerts');
    }
  );
});

Person.find({}).remove(function() {
  Person.create({
      name: "מרואן קוואסמה",
      associated: "חמאס, עמר אבו-עיישה, חמולת קוואסמה",
      picture: "http://www.haaretz.co.il/polopoly_fs/1.2360425.1403801662!/image/3934528164.jpg_gen/derivatives/landscape_157/3934528164.jpg",
      description: "חבר בחמולת קוואסמה. היה חלק מחוליית המחבלים שביצעה את החטיפה של גיל-עד מיכאל שער, נפתלי יעקב פרנקל ואיל יפרח. מרואן גר בחברון",
      cars:["12-348-93"]
    },
    {
      name: "עמר אבו-עיישה",
      associated: "חמאס, מרואן קוואסמה",
      picture: "http://www.haaretz.co.il/polopoly_fs/1.2360426.1403803107!/image/3165438367.jpg_gen/derivatives/landscape_157/3165438367.jpg",
      description: "חלק מחולית המחבלים שביצעה את החטיפה לפני מבצע שובו אחים. פעיל חמאס מוכר לכוחות המערכת ונחשב למסוכן. מתגורר ופועל באזור חברון",
      cars:["12-348-92"]
    },
    {
      name: "בני סלע",
      associated: "",
      picture: "http://msc.wcdn.co.il/w/w-700/270845-5.jpg",
      description: "אנס מורשע שנחשב מסוכן מאוד לציבור. בעל היסטוריה של בריחה ממתקני כליאה של השבס. יש לטפל בזהירות מירבית"
  },
  {
    name: "אחמד יאסין",
    associated: "חמאס",
    picture: "http://upload.wikimedia.org/wikipedia/he/e/ee/Ahmed_Yassin.JPG",
    description: "אחמד איסמעיל חסן יאסין (בערבית: أحمد ياسين; 1 בינואר 1937 – 22 במרץ 2004) היה מייסדו ומנהיגו של ארגון חמאס, והעניק ביסוס תאולוגי וחותם דתי לטרור. כונה השייח יאסין על שום מעמדו כמנהיג תנועת חמאס. נהרג בסיכול ממוקד שביצע בו צהל במהלך האינתיפאדה השנייה."
  }, function() {
      console.log('finished populating persons');
    }
  );
});


