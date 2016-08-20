# This is all-in-one-package version of general-category module.
data =
  '1.1.5': require \./data/1.1.5.json
  '2.0.14': require \./data/2.0.14.json
  '2.1.2': require \./data/2.1.2.json
  '2.1.5': require \./data/2.1.5.json
  '2.1.8': require \./data/2.1.8.json
  '2.1.9': require \./data/2.1.9.json
  '3.0.0': require \./data/3.0.0.json
  '3.0.1': require \./data/3.0.1.json
  '3.1.0': require \./data/3.1.0.json
  '3.2.0': require \./data/3.2.0.json
  '4.0.0': require \./data/4.0.0.json
  '4.0.1': require \./data/4.0.1.json
  '4.1.0': require \./data/4.1.0.json
  '5.0.0': require \./data/5.0.0.json
  '5.1.0': require \./data/5.1.0.json
  '5.2.0': require \./data/5.2.0.json
  '6.0.0': require \./data/6.0.0.json
  '6.1.0': require \./data/6.1.0.json
  '6.2.0': require \./data/6.2.0.json
  '6.3.0': require \./data/6.3.0.json
  '7.0.0': require \./data/7.0.0.json
  '8.0.0': require \./data/8.0.0.json
  '9.0.0': require \./data/9.0.0.json

module.exports = require('./general-category.js')(data)
