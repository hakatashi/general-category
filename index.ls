# This is all-in-one-package version of general-category module.
data = require \./data/index.json

module.exports = require('./general-category.js')(data)
