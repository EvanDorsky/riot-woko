var mongoose = require('mongoose');
var Schema = mongoose.Schema;

module.exports = mongoose.model('Article', new Schema({
	author: String,
	title: String,
	source: String,
	content: String,
  category: { type: Schema.Types.ObjectId, ref: 'Category' },
	created: Date
}));