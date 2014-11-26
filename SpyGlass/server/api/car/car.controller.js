'use strict';

var _ = require('lodash');
var Car = require('./car.model');
var Camera = require('../camera/camera.model');
var async = require('../../../node_modules/async/lib/async');

// Get list of cars
exports.index = function(req, res) {
  Car.find(function (err, cars) {
    if(err) { return handleError(res, err); }
    return res.json(200, cars);
  });
};

// Get list of cameras
exports.getCameras = function(req, res) {
  Camera.find(function (err, cars) {
    if(err) { return handleError(res, err); }
    return res.json(200, cars);
  });
};

function getCarNextLocation(car, callback){
  Car.find({carId: car.carId}).where('date').gt(car.date).sort('date').limit(1).populate('camId').exec(function(err, nextCar){
    if(err) { return handleError(res, err); }
    var newCar = car._doc;
    if(nextCar[0]){
      console.log(nextCar[0]);
      newCar.nextLocation = {location: nextCar[0].camId, date: nextCar[0].date};
      console.log(newCar);
    }
    callback(null,newCar);
  })
}

// Get cars that passed through a location
exports.getByLocation = function(req, res) {
  Car.find({camId: req.params.locationId}).where('date').gt(new Date(req.params.minDate)).lt(new Date(req.params.maxDate)).sort('-date').populate('camId').exec(function (err, cars) {
    if(err) { return handleError(res, err); }
    if(!cars) { return res.send(404); }
    async.concat(cars, getCarNextLocation, function(err, locations){
      if(err) { return handleError(res, err); }
      return res.json(locations);
    })
  });
};
// Get a single car
exports.show = function(req, res) {
  Car.find({carId : req.params.id}).where('date').gt(new Date(req.params.minDate)).lt(new Date(req.params.maxDate)).sort('-date').populate('camId').exec(function (err, car) {
    if(err) { return handleError(res, err); }
    if(!car) { return res.send(404); }
    return res.json(car);
  });
};

// Creates a new car in the DB.
exports.create = function(req, res) {
  Car.create(req.body, function(err, car)
  {
    if(err) return handleError(res, err);
    return res.json(200, car);
  });
};

// Updates an existing car in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Car.findById(req.params.id, function (err, car) {
    if (err) { return handleError(res, err); }
    if(!car) { return res.send(404); }
    var updated = _.merge(car, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.json(200, car);
    });
  });
};

// Deletes a car from the DB.
exports.destroy = function(req, res) {
  Car.findById(req.params.id, function (err, car) {
    if(err) { return handleError(res, err); }
    if(!car) { return res.send(404); }
    car.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.send(204);
    });
  });
};

function handleError(res, err) {
  return res.send(500, err);
}
