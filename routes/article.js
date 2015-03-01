var express = require('express');
var mongoose = require('mongoose');
var Article = require('../models/article');
var handleErr = require('../utils/utils').handleErr;

var router = express.Router();

// get all articles
router.get('/', function(req, res) {
	Article.find(function(err, articles) {
		if (err)
			return handleErr(err, 'article:12');

		res.json(articles);
	});
});

// get an article by id
router.get('/:id', function(req, res) {
	res.end();
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
			return handleErr(err, 'article:33');

		res.json(req.body);
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