var mongoose = require('mongoose');
var Schema = mongoose.Schema;

module.exports = mongoose.model('Category', new Schema({
  title: String,
  created: Date,
  articles: [{ type: Schema.Types.ObjectId, ref: 'Article' }]
}));