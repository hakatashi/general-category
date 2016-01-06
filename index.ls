require! {
  \assert
  \./data.json
  \code-point-at
}

# TODO: more neat sort algorithm
versions = Object.keys data .sort!

long-names =
  Lu: \Uppercase_Letter
  Ll: \Lowercase_Letter
  Lt: \Titlecase_Letter
  Lm: \Modifier_Letter
  Lo: \Other_Letter
  Mn: \Nonspacing_Mark
  Mc: \Spacing_Mark
  Me: \Enclosing_Mark
  Nd: \Decimal_Number
  Nl: \Letter_Number
  No: \Other_Number
  Pc: \Connector_Punctuation
  Pd: \Dash_Punctuation
  Ps: \Open_Punctuation
  Pe: \Close_Punctuation
  Pi: \Initial_Punctuation
  Pf: \Final_Punctuation
  Po: \Other_Punctuation
  Sm: \Math_Symbol
  Sc: \Currency_Symbol
  Sk: \Modifier_Symbol
  So: \Other_Symbol
  Zs: \Space_Separator
  Zl: \Line_Separator
  Zp: \Paragraph_Separator
  Cc: \Control
  Cf: \Format
  Cs: \Surrogate
  Co: \Private_Use
  Cn: \Unassigned

long-category-names =
  L: \Letter
  M: \Mark
  N: \Number
  P: \Punctuation
  S: \Symbol
  Z: \Separator
  C: \Other

module.exports = (character, options = {}) ->
  # Look up codepoint for given character
  codepoint = switch typeof! character
    | \String => code-point-at character
    | \Number => character
    | otherwise => NaN

  throw new Error 'Invalid character' if isNaN codepoint
  throw new Error 'Invalid character' unless 0x0 <= codepoint <= 0x10FFFF

  # Switch Unicode version to use as source
  # Default is latest version available
  if options.version
    unicode = data[options.version]
  else
    unicode = data[versions[* - 1]]

  throw new Error 'Invalid/Unavailable Unicode version specified' unless unicode

  codepoints = Object.keys unicode

  # Use binary search algorithm
  hi = codepoints.length
  lo = 0

  while hi - lo > 1
    mid = Math.floor (hi + lo) / 2
    test = parse-int codepoints[mid]

    if codepoint < test
      hi = mid
    else if codepoint is test
      hi = lo = mid
      break
    else if test < codepoint
      lo = mid

  unless options.detailed
    if options.long
      return long-names[unicode[codepoints[lo]]]
    else
      return unicode[codepoints[lo]]
  else
    if options.long
      return
        large: long-category-name[unicode[codepoints[lo]].0]
        small: long-names[unicode[codepoints[lo]]]
    else
      return
        large: unicode[codepoints[lo]].0
        small: unicode[codepoints[lo]]
