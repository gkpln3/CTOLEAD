'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var CarSchema = new Schema({
  carId: String,
  color: String,
  suspicious: Boolean,
  camId: {type:Number, ref: 'Camera'},
  date: Date
});

module.exports = mongoose.model('Car', CarSchema);
