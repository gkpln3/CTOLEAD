/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Alert = require('./alert.model');

exports.register = function(socket) {
  Alert.schema.post('save', function (doc) {
    onSave(socket, doc);
  });
  Alert.schema.post('remove', function (doc) {
    onRemove(socket, doc);
  });
}

function onSave(socket, doc, cb) {
  socket.emit('alert:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('alert:remove', doc);
}