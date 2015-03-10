var express = require('express');
var session = require('express-session');
var path = require('path');
var request = require('request');

// routes
var index = require('./routes/index');
var article = require('./routes/article');

var mongoose = require('mongoose');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var exphbs = require('express-handlebars');

var app = express();

app.engine('handlebars', exphbs({defaultLayout: 'main'}));
app.set('view engine', 'handlebars');

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(session({
	secret: 'secret',
	resave: false,
	saveUninitialized: true
}));

// mongo
var db = mongoose.connection;
db.on('error', console.error);

var MONGO = process.env.MONGOURI_WIKI || 'mongodb://localhost/test';
mongoose.connect(MONGO);

// routes
app.get('/', index.home);
app.use('/article', article);

// olinauth
app.get('/olinauth/login', function(req, res) {
	res.redirect('http://www.olinapps.com/external?callback=http://localhost:3000/olinauth/auth');
})

app.post('/olinauth/auth', function(req, res) {
	req.session.olinuser = {};

	request('http://www.olinapps.com/api/me?sessionid='+req.body.sessionid, function(err, response, body) {
			body = JSON.parse(body);
			req.session.olinuser.sessionid = req.body.sessionid;
			req.session.olinuser.email = body.user.email;
			req.session.olinuser.id = body.user.id;

			res.redirect('/');
	})
})

app.listen(process.env.PORT || 3000);