require! {
  \assert
  \code-point-at
  \./util.js : {buffer-to-integer-array}
  \./categories.js : {long-names, long-category-names}
}

module.exports = (data) ->
  # TODO: more neat sort algorithm
  versions = Object.keys data .sort!

  sorted-category-names = Object.keys long-names .sort!

  # Build data hash from array of codepints
  hashed-data = Object.create null

  for version, packed-unicode of data
    unicode = packed-unicode |> Buffer.from _, \binary |> buffer-to-integer-array

    hashed-unicode = Object.create null
    current-codepoint = 0

    while unicode.length > 0
      codepoint-diff = unicode.shift!
      category-index = unicode.shift!

      current-codepoint += codepoint-diff
      hashed-unicode[current-codepoint] = sorted-category-names[category-index]

    hashed-data[version] = hashed-unicode

  return (character, options = {}) ->
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
      unicode = hashed-data[options.version]
    else
      unicode = hashed-data[versions[* - 1]]

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
          large: long-category-names[unicode[codepoints[lo]].0]
          small: long-names[unicode[codepoints[lo]]]
      else
        return
          large: unicode[codepoints[lo]].0
          small: unicode[codepoints[lo]]
