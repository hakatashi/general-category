require! {
  \assert
  \./data.json
  \code-point-at
}

# TODO: more neat sort algorithm
versions = Object.keys data .sort!

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

  return unicode[codepoints[lo]]
