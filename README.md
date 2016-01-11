# general-category

[![Build Status](https://travis-ci.org/hakatashi/general-category.svg?branch=master)](https://travis-ci.org/hakatashi/general-category)

Look up [General_Category](http://unicode.org/reports/tr44/#General_Category) of Unicode character with JavaScript.

## Usage

```js
const category = require('general-category');

// Just gimme character and get category.
category('Å'); // -> 'Lu'

// This module is aware of surrogate pairs, of course.
category('\u{1F600}'); // -> 'So'

// Providing Unicode code point also works.
category(0x0020); // -> 'Zs'

// You can get long_name instead of abbreviated form.
console.log(category('Ä', {long: true})); // -> 'Uppercase_Letter'

// You can also get detaild information of category.
console.log(category('Ä', {detailed: true})); // -> { large: 'L', small: 'Lu' }
```

## API

This module exposes single function `category(character[, options])`.

* `character` [String | Number]: Character or code point to look up for General_Category
* `options` [Object]:
	* `long` [Boolean]: Returns long_name instead of abbreviated form. Default is `false`.
	* `detailed` [Boolean]: Returns detailed category information instead of plain string. Default is `false`.
* **return** [String | Object]: General_Category of the given character. If `options.detailed` is set `true`, returns object with detailed category information.
