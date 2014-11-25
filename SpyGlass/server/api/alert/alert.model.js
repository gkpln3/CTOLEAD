'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var AlertSchema = new Schema({
  carId: String,
  date: Date,
  pushed: {type: Boolean, default:false},
  alertPathSource: {type:Number, ref:'Camera'} ,
  alertPathDest: {type:Number, ref:'Camera'},
  percentage: Number,
  usualPathSource: {type: Number, ref:'Camera'},
  usualPathDest: {type:Number, ref:'Camera'},
  usualPercentage: Number
});

module.exports = mongoose.model('Alert', AlertSchema);
