'use strict';

var express = require('express');
var controller = require('./car.controller');
var auth = require('../../auth/auth.service');

var router = express.Router();

router.get('/', controller.index);
router.get('/cameras', controller.getCameras);
router.get('/location/:locationId/:minDate/:maxDate', controller.getByLocation);
router.get('/:id/:minDate/:maxDate', controller.show);
router.post('/', controller.create);
router.put('/:id', auth.hasRole('admin'), controller.update);
router.patch('/:id', auth.hasRole('admin'), controller.update);
router.delete('/:id', auth.hasRole('admin'), controller.destroy);

module.exports = router;
