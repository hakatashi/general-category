require! {
  chai: {expect}
  '../': general-category
}

It = global.it

assets =
  * char: '\n'
    codepoint: 0x000A
    category: \Cc
  # ZERO WIDTH JOINbER
  * char: '\u200D'
    codepoint: 0x200D
    category: \Cf
  * char: '\u0883'
    codepoint: 0x0883
    category: \Cn
  * char: '\uE6A3'
    codepoint: 0xE6A3
    category: \Co
  * char: '\uDE7B'
    codepoint: 0xDE7B
    category: \Cs
  * char: 'p'
    codepoint: 0x0070
    category: \Ll
  # MODIFIER LETTER SMALL F
  * char: '\u1DA0'
    codepoint: 0x1DA0
    category: \Lm
  * char: 'ぷ'
    codepoint: 0x3077
    category: \Lo
  * char: 'ǈ'
    codepoint: 0x01C8
    category: \Lt
  * char: 'Đ'
    codepoint: 0x0110
    category: \Lu
  # JAVANESE VOWEL SIGN TALING
  * char: '\uA9BA'
    codepoint: 0xA9BA
    category: \Mc
  # COMBINING ENCLOSING CIRCLE
  * char: '\u20DD'
    codepoint: 0x20DD
    category: \Me
  # COMBINING KATAKANA-HIRAGANA VOICED SOUND MARK
  * char: '\u3099'
    codepoint: 0x3099
    category: \Mn
  * char: '9'
    codepoint: 0x0039
    category: \Nd
  * char: 'Ⅸ'
    codepoint: 0x2168
    category: \Nl
  * char: '⁹'
    codepoint: 0x2079
    category: \No
  * char: '_'
    codepoint: 0x005F
    category: \Pc
  * char: '-'
    codepoint: 0x002D
    category: \Pd
  * char: '('
    codepoint: 0x0028
    category: \Ps
  * char: ')'
    codepoint: 0x0029
    category: \Pe
  * char: '«'
    codepoint: 0x00AB
    category: \Pi
  * char: '»'
    codepoint: 0x00BB
    category: \Pf
  * char: '!'
    codepoint: 0x0021
    category: \Po
  * char: '$'
    codepoint: 0x0024
    category: \Sc
  * char: '^'
    codepoint: 0x005E
    category: \Sk
  * char: '='
    codepoint: 0x003D
    category: \Sm
  * char: '©'
    codepoint: 0x00A9
    category: \So
  # LINE SEPARATOR
  * char: '\u2028'
    codepoint: 0x2028
    category: \Zl
  # PARAGRAPH SEPARATOR
  * char: '\u2029'
    codepoint: 0x2029
    category: \Zp
  * char: ' '
    codepoint: 0x0020
    category: \Zs

  # Surrogate Pairs

  # GREEK ACROPHONIC ATTIC FIFTY
  * char: '\uD800\uDD44'
    codepoint: 0x10144
    category: \Nl
  # EGYPTIAN HIEROGLYPH W018
  * char: '\uD80C\uDFC5'
    codepoint: 0x133C5
    category: \Lo
  * char: '\uD842\uDFB7'
    codepoint: 0x20BB7
    category: \Lo

describe 'Basic usage' ->
  It 'basically works' ->
    for asset in assets
      expect general-category asset.char
      .to.equal asset.category

  It 'can accept codepoint number as input' ->
    for asset in assets
      expect general-category asset.codepoint
      .to.equal asset.category

  It 'throws error when zero-length string is given' ->
    expect -> general-category ''
    .to.throw Error

  It 'throws error when non-string or non-number is given' ->
    expect -> general-category!
    .to.throw Error

    expect -> general-category {}
    .to.throw Error

    expect -> general-category null
    .to.throw Error

    expect -> general-category /foobar/
    .to.throw Error

  It 'throws error when invalid code point is given' ->
    expect -> general-category -42
    .to.throw Error

    expect -> general-category 0x110000
    .to.throw Error

    expect -> general-category NaN
    .to.throw Error

    expect -> general-category Infinity
    .to.throw Error
