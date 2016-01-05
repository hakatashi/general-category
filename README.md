# general-category

[![Build Status](https://travis-ci.org/hakatashi/general-category.svg?branch=master)](https://travis-ci.org/hakatashi/general-category)

Look up [General_Category](http://unicode.org/reports/tr44/#General_Category) of Unicode for given character with JavaScript.

## Usage

```js
const category = require('general-category');

category('Å'); // -> 'Lu'
category('\u{1F600}'); // -> 'So'
category(0x0020); // -> 'Zs'
```

## API

This module exposes single function `category(character[, options])`.

* `character` [String | Number]: Character or code point to look up for General_Category
* `options` [Object]: Not yet implemented.
* **return** [String]: General_Category of the given character
