require! {
  chai: {expect}
  '../': general-category
}

It = global.it

assets =
  * char: '\n'
    category: \Cc
  # ZERO WIDTH JOINbER
  * char: '\u200D'
    category: \Cf
  * char: '\u0883'
    category: \Cn
  * char: '\uE6A3'
    category: \Co
  * char: '\uDE7B'
    category: \Cs
  * char: 'p'
    category: \Ll
  # MODIFIER LETTER SMALL F
  * char: '\u1DA0'
    category: \Lm
  * char: 'ぷ'
    category: \Lo
  * char: 'ǈ'
    category: \Lt
  * char: 'Đ'
    category: \Lu
  # JAVANESE VOWEL SIGN TALING
  * char: '\uA9BA'
    category: \Mc
  # COMBINING ENCLOSING CIRCLE
  * char: '\u20DD'
    category: \Me
  # COMBINING KATAKANA-HIRAGANA VOICED SOUND MARK
  * char: '\u3099'
    category: \Mn
  * char: '9'
    category: \Nd
  * char: 'Ⅸ'
    category: \Nl
  * char: '⁹'
    category: \No
  * char: '_'
    category: \Pc
  * char: '-'
    category: \Pd
  * char: '('
    category: \Ps
  * char: ')'
    category: \Pe
  * char: '«'
    category: \Pi
  * char: '»'
    category: \Pf
  * char: '!'
    category: \Po
  * char: '$'
    category: \Sc
  * char: '^'
    category: \Sk
  * char: '='
    category: \Sm
  * char: '©'
    category: \So
  # LINE SEPARATOR
  * char: '\u2028'
    category: \Zl
  # PARAGRAPH SEPARATOR
  * char: '\u2029'
    category: \Zp
  * char: ' '
    category: \Zs

describe 'Basic usage' ->
  It 'basically works' ->
    for asset in assets
      expect general-category asset.char
      .to.equal asset.category
