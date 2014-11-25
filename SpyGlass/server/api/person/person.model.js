'use strict';

var mongoose = require('mongoose'),
  Schema = mongoose.Schema;

var PersonSchema = new Schema({
  name: {type: String },
  associated: String,
  picture: String,
  description: String,
  cars: [String]
});

module.exports = mongoose.model('Person', PersonSchema);
