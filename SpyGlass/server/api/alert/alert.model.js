'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var AlertSchema = new Schema({
  carId: String,
  date: Date,
});

module.exports = mongoose.model('Alert', AlertSchema);
