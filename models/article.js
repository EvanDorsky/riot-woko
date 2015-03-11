var mongoose = require('mongoose');
var Schema = mongoose.Schema;

module.exports = mongoose.model('Article', new Schema({
	_creator: String,
	header: String,
	content: String,
	created: Date
}));