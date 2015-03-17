var express = require('express');
var request = require('request');
var mongoose = require('mongoose');
var handleErr = require('../utils/utils').handleErr;

var router = express.Router();

router.get('/login', function(req, res) {
	res.redirect('http://www.olinapps.com/external?callback='+'http://localhost:3000/olinauth/auth');
})

router.get('/logout', function(req, res) {
	req.session.olinuser = null;

	res.redirect('/');
})

router.post('/auth', function(req, res) {
	req.session.olinuser = {};

	request('http://www.olinapps.com/api/me?sessionid='+req.body.sessionid, function(err, response, body) {
			body = JSON.parse(body);
			req.session.olinuser.sessionid = req.body.sessionid;
			req.session.olinuser.email = body.user.email;
			req.session.olinuser.id = body.user.id;

			res.redirect('/');
	})
})

module.exports = router;

module.exports.isAuth = function(req, res, next) {
	if (req.session.olinuser)
		return next();

	res.json(null);
}