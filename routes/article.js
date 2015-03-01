var express = require('express');
var mongoose = require('mongoose');
var Article = require('../models/article');

var router = express.Router();

// get an article
router.get('/', function(req, res) {
	console.log('HIIIIIIIIIIIIII');
	res.json({
		gotit: true
	});
});

// edit an article
router.put('/', function(req, res) {
	var newArticle = req.body;

	Article.update()
	res.json({
		gotit: true
	});
});

// make a new article
router.post('/', function(req, res) {
	req.body.created = new Date();

	new Article(req.body).save(function(err) {
		if (err)
			return console.error('Error:', err);
	});

	res.json({
		gotit: true
	});
});

// delete an article by id
router.delete('/', function(req, res) {
	var newArticle = req.body;

	// Article.update()
	res.json({
		gotit: true
	});
});

module.exports = router;