var express = require('express');
var mongoose = require('mongoose');
var Article = require('../models/article');
var handleErr = require('../utils/utils').handleErr;
// var isAuth = require('../routes/olinauth/')

var router = express.Router();

// get all articles
router.get('/', function(req, res) {
	Article.find().sort({ created: -1 }).exec(function(err, articles) {
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
router.put('/:id', function(req, res) {
	req.body.author = req.session.olinuser.id;
	
	Article.update({ _id: req.params.id }, req.body, function(err) {
		if (err)
			return handleErr(err, 'article:27');

		res.json(req.body);
	})
});

// make a new article
router.post('/', function(req, res) {
	req.body.created = new Date();
	req.body.author = req.session.olinuser.id;

	new Article(req.body).save(function(err, article) {
		if (err)
			return handleErr(err, 'article:33');

		res.json(article);
	});
});

// delete an article by id
router.delete('/:id', function(req, res) {
	Article.findOneAndRemove({ _id: req.params.id }, function(err) {
		if (err)
			return handleErr(err, 'article:46')

		res.json({ success: true });
	})
});

module.exports = router;