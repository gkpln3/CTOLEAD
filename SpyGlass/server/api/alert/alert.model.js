'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var AlertSchema = new Schema({
  carId: String,
  date: Date,
  alertPathSource: {type:Number, ref:'Camera'} ,
  alertPathDest: {type:Number, ref:'Camera'},
  percentage: Number
});

module.exports = mongoose.model('Alert', AlertSchema);
