'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var CameraSchema = new Schema({
  _id: Number,
  coordinate: {latitude: String, longitude: String },
  location: String
});

module.exports = mongoose.model('Camera', CameraSchema);
