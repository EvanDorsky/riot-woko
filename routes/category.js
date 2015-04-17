var express = require('express');
var mongoose = require('mongoose');
var Category = require('../models/category');
var handleErr = require('../utils/utils').handleErr;

var router = express.Router();

// get all categories
router.get('/', function(req, res) {
  Category.find().sort({ created: -1 }).exec(function(err, categories) {
    if (err)
      return handleErr(err, 'category:12');

    res.json(categories);
  });
});

// get a category by id
router.get('/:id', function(req, res) {
  res.end();
});

// edit a category
router.put('/:id', function(req, res) {
  req.body.author = req.session.olinuser.id;
  
  Category.update({ _id: req.params.id }, req.body, function(err) {
    if (err)
      return handleErr(err, 'category:29');

    res.json(req.body);
  })
});

// make a new category
router.post('/', function(req, res) {
  req.body.created = new Date();
  req.body.author = req.session.olinuser.id;

  new Category(req.body).save(function(err, category) {
    if (err)
      return handleErr(err, 'category:42');

    res.json(category);
  });
});

// delete a category by id
router.delete('/:id', function(req, res) {
  Category.findOneAndRemove({ _id: req.params.id }, function(err) {
    if (err)
      return handleErr(err, 'category:52')

    res.json({ success: true });
  })
});

module.exports = router;