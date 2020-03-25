# general-category

[![npm version][npm-image]][npm-url]
[![Build Status][travis-image]][travis-url]
[![Dependency Status][david-image]][david-url]
[![devDependency Status][david-dev-image]][david-dev-url]

[![semantic-release][semrel-image]][semrel-url]
[![Commitizen friendly][commitizen-image]][commitizen-url]


[npm-image]: https://img.shields.io/npm/v/general-category.svg
[npm-url]: https://www.npmjs.com/package/general-category
[travis-image]: https://travis-ci.org/hakatashi/general-category.svg?branch=master
[travis-url]: https://travis-ci.org/hakatashi/general-category
[david-image]: https://david-dm.org/hakatashi/general-category.svg
[david-url]: https://david-dm.org/hakatashi/general-category
[david-dev-image]: https://david-dm.org/hakatashi/general-category/dev-status.svg
[david-dev-url]: https://david-dm.org/hakatashi/general-category#info=devDependencies
[semrel-image]: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
[semrel-url]: https://github.com/semantic-release/semantic-release
[commitizen-image]: https://img.shields.io/badge/commitizen-friendly-brightgreen.svg
[commitizen-url]: http://commitizen.github.io/cz-cli/

Look up [General_Category](http://unicode.org/reports/tr44/#General_Category) of Unicode character with JavaScript.

## News: The package was considerably slimed down :arrow_down: as of version 1.4.0 :raised_hands:

```sh
$ du -h `npm pack general-category@1.3`
184K    general-category-1.3.0.tgz
$ du -h `npm pack general-category@1.4`
24K     general-category-1.4.0.tgz
$ du -h `npm pack general-category@1.5`
17K     general-category-1.5.0.tgz
```

## Usage

```js
const category = require('general-category');

// Just gimme character and you'll get category.
category('Å'); //=> 'Lu'

// This module is aware of surrogate pairs.
category('\u{1F600}'); //=> 'So'

// Providing code point also works.
category(0x0020); //=> 'Zs'

// You'll get category data with latest version of Unicode by default.
// You can switch it by `version` option
category('\u{1F600}', {version: '6.0.0'}); //=> 'Cn'

// If you are only interested in the specific version of Unicode,
// you can require the module with limited data loaded.
const category3_2_0 = require('general-category/3.2.0');
category3_2_0('\u{1F600}'); //=> 'Cn'

// 'latest' version also works.
const categoryLatest = require('general-category/latest');
categoryLatest('\u{1F600}'); //=> 'So'

// You can get long_name instead of an abbreviated one.
category('Ä', {long: true}); //=> 'Uppercase_Letter'

// You can also get detaild information of category.
category('Ä', {detailed: true}); //=> { large: 'L', small: 'Lu' }
```

## API

This module exposes single function `category(character[, options])`.

* `character` [String | Number]: Character or code point to look up for General_Category
* `options` [Object]:
	* `long` [Boolean]: Returns long_name instead of abbreviated form. Default is `false`.
	* `detailed` [Boolean]: Returns detailed category information instead of plain string. Default is `false`.
	* `version` [String | Null]: Version number to use as unicode data source. You can set `null` to use latest version included. These versions are derived from [node-unicode-data](https://github.com/mathiasbynens/node-unicode-data) and currently all available versions are:
		* 1.1.5
		* 2.0.14
		* 2.1.2
		* 2.1.5
		* 2.1.8
		* 2.1.9
		* 3.0.0
		* 3.0.1
		* 3.1.0
		* 3.2.0
		* 4.0.0
		* 4.0.1
		* 4.1.0
		* 5.0.0
		* 5.1.0
		* 5.2.0
		* 6.0.0
		* 6.1.0
		* 6.2.0
		* 6.3.0
		* 7.0.0
		* 8.0.0
		* 9.0.0
* **return** [String | Object]: General_Category of the given character. If `options.detailed` is set `true`, returns object with detailed category information.
