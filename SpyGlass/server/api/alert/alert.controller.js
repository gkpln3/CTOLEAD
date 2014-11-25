'use strict';

var _ = require('lodash');
var Alert = require('./alert.model');

// Get list of alerts
exports.index = function(req, res) {
  Alert.find().populate('alertPathSource').populate('alertPathDest').exec(function (err, alerts) {
    if(err) { return handleError(res, err); }
    return res.json(200, alerts);
  });
};

// Get a single alert
exports.show = function(req, res) {
  Alert.findById(req.params.id, function (err, alert) {
    if(err) { return handleError(res, err); }
    if(!alert) { return res.send(404); }
    return res.json(alert);
  });
};

// Creates a new alert in the DB.
exports.create = function(req, res) {
  if(!req.body)
    return res.json(422, {message: "No data entered"});
  Alert.create(req.body, function(err, alert) {
    if(err) { return handleError(res, err); }
    return res.json(201, alert);
  });
};

// Updates an existing alert in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Alert.findById(req.params.id, function (err, alert) {
    if (err) { return handleError(res, err); }
    if(!alert) { return res.send(404); }
    var updated = _.merge(alert, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.json(200, alert);
    });
  });
};

// Deletes a alert from the DB.
exports.destroy = function(req, res) {
  Alert.findById(req.params.id, function (err, alert) {
    if(err) { return handleError(res, err); }
    if(!alert) { return res.send(404); }
    alert.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.send(204);
    });
  });
};

function handleError(res, err) {
  return res.send(500, err);
}
