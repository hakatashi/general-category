require! {
  chai: {expect}
  '../': general-category
}

It = global.it

assets =
  * char: '\n'
    codepoint: 0x000A
    category: \Cc
    large-category: \C
    category-name: \Control
    large-category-name: \Other
  # ZERO WIDTH JOINbER
  * char: '\u200D'
    codepoint: 0x200D
    category: \Cf
    large-category: \C
    category-name: \Format
    large-category-name: \Other
  * char: '\u0883'
    codepoint: 0x0883
    category: \Cn
    large-category: \C
    category-name: \Unassigned
    large-category-name: \Other
  * char: '\uE6A3'
    codepoint: 0xE6A3
    category: \Co
    large-category: \C
    category-name: \Private_Use
    large-category-name: \Other
  * char: '\uDE7B'
    codepoint: 0xDE7B
    category: \Cs
    large-category: \C
    category-name: \Surrogate
    large-category-name: \Other
  * char: 'p'
    codepoint: 0x0070
    category: \Ll
    large-category: \L
    category-name: \Lowercase_Letter
    large-category-name: \Letter
  # MODIFIER LETTER SMALL F
  * char: '\u1DA0'
    codepoint: 0x1DA0
    category: \Lm
    large-category: \L
    category-name: \Modifier_Letter
    large-category-name: \Letter
  * char: 'ぷ'
    codepoint: 0x3077
    category: \Lo
    large-category: \L
    category-name: \Other_Letter
    large-category-name: \Letter
  * char: 'ǈ'
    codepoint: 0x01C8
    category: \Lt
    large-category: \L
    category-name: \Titlecase_Letter
    large-category-name: \Letter
  * char: 'Đ'
    codepoint: 0x0110
    category: \Lu
    large-category: \L
    category-name: \Uppercase_Letter
    large-category-name: \Letter
  # JAVANESE VOWEL SIGN TALING
  * char: '\uA9BA'
    codepoint: 0xA9BA
    category: \Mc
    large-category: \M
    category-name: \Spacing_Mark
    large-category-name: \Mark
  # COMBINING ENCLOSING CIRCLE
  * char: '\u20DD'
    codepoint: 0x20DD
    category: \Me
    large-category: \M
    category-name: \Enclosing_Mark
    large-category-name: \Mark
  # COMBINING KATAKANA-HIRAGANA VOICED SOUND MARK
  * char: '\u3099'
    codepoint: 0x3099
    category: \Mn
    large-category: \M
    category-name: \Nonspacing_Mark
    large-category-name: \Mark
  * char: '9'
    codepoint: 0x0039
    category: \Nd
    large-category: \N
    category-name: \Decimal_Number
    large-category-name: \Number
  * char: 'Ⅸ'
    codepoint: 0x2168
    category: \Nl
    large-category: \N
    category-name: \Letter_Number
    large-category-name: \Number
  * char: '⁹'
    codepoint: 0x2079
    category: \No
    large-category: \N
    category-name: \Other_Number
    large-category-name: \Number
  * char: '_'
    codepoint: 0x005F
    category: \Pc
    large-category: \P
    category-name: \Connector_Punctuation
    large-category-name: \Punctuation
  * char: '-'
    codepoint: 0x002D
    category: \Pd
    large-category: \P
    category-name: \Dash_Punctuation
    large-category-name: \Punctuation
  * char: '('
    codepoint: 0x0028
    category: \Ps
    large-category: \P
    category-name: \Open_Punctuation
    large-category-name: \Punctuation
  * char: ')'
    codepoint: 0x0029
    category: \Pe
    large-category: \P
    category-name: \Close_Punctuation
    large-category-name: \Punctuation
  * char: '«'
    codepoint: 0x00AB
    category: \Pi
    large-category: \P
    category-name: \Initial_Punctuation
    large-category-name: \Punctuation
  * char: '»'
    codepoint: 0x00BB
    category: \Pf
    large-category: \P
    category-name: \Final_Punctuation
    large-category-name: \Punctuation
  * char: '!'
    codepoint: 0x0021
    category: \Po
    large-category: \P
    category-name: \Other_Punctuation
    large-category-name: \Punctuation
  * char: '$'
    codepoint: 0x0024
    category: \Sc
    large-category: \S
    category-name: \Currency_Symbol
    large-category-name: \Symbol
  * char: '^'
    codepoint: 0x005E
    category: \Sk
    large-category: \S
    category-name: \Modifier_Symbol
    large-category-name: \Symbol
  * char: '='
    codepoint: 0x003D
    category: \Sm
    large-category: \S
    category-name: \Math_Symbol
    large-category-name: \Symbol
  * char: '©'
    codepoint: 0x00A9
    category: \So
    large-category: \S
    category-name: \Other_Symbol
    large-category-name: \Symbol
  # LINE SEPARATOR
  * char: '\u2028'
    codepoint: 0x2028
    category: \Zl
    large-category: \Z
    category-name: \Line_Separator
    large-category-name: \Separator
  # PARAGRAPH SEPARATOR
  * char: '\u2029'
    codepoint: 0x2029
    category: \Zp
    large-category: \Z
    category-name: \Paragraph_Separator
    large-category-name: \Separator
  * char: ' '
    codepoint: 0x0020
    category: \Zs
    large-category: \Z
    category-name: \Space_Separator
    large-category-name: \Separator

  # Surrogate Pairs

  # GREEK ACROPHONIC ATTIC FIFTY
  * char: '\uD800\uDD44'
    codepoint: 0x10144
    category: \Nl
    large-category: \N
    category-name: \Letter_Number
    large-category-name: \Number
  # EGYPTIAN HIEROGLYPH W018
  * char: '\uD80C\uDFC5'
    codepoint: 0x133C5
    category: \Lo
    large-category: \L
    category-name: \Other_Letter
    large-category-name: \Letter
  * char: '\uD842\uDFB7'
    codepoint: 0x20BB7
    category: \Lo
    large-category: \L
    category-name: \Other_Letter
    large-category-name: \Letter

describe 'Basic options' ->
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

describe '`long` option' ->
  It 'returns long category name' ->
    for asset in assets
      expect general-category asset.char, {+long}
      .to.equal asset.category-name

describe '`detailed` option' ->
  It 'returns detailed category object' ->
    for asset in assets
      expect general-category asset.char, {+detailed}
      .to.deep.equal {
        large: asset.large-category
        small: asset.category
      }

  It 'returns detailed category object with long name when combined with `long` option' ->
    for asset in assets
      expect general-category asset.char, {+detailed, +long}
      .to.deep.equal {
        large: asset.large-category-name
        small: asset.category-name
      }
