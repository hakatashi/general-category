# Pack array of integers to compact buffer

require! {
  'prelude-ls': {unfoldr, map, concat}
}

# Here the buffer is represented by little-endian base-128 digits,
# whose MSB is 1 for non-lowest digit and 0 for lowest digit.

export integer-array-to-buffer = ->
  it |> map ->
    it |> (+ 1) |> unfoldr ->
      if it is 0 then null
      else
        modulo = it %% 128
        base = it .>>. 7
        modulo .|.= 2~1000_0000 if base is 0

        [modulo, base]
    # Invert bits to avoid things like '\u0000' in outputed JSON file
    |> map (.^. 0xFF)
  |> concat
  |> Buffer.from

export buffer-to-integer-array = (buffer) ->
  ret = []
  carried = register = 0

  for byte in buffer
    # Invert bits
    byte .^.= 0xFF

    register += (byte .&. 2~0111_1111) .<<. (carried * 7)
    carried++

    unless (byte .&. 2~1000_0000) is 0
      ret.push register - 1
      carried = register = 0

  ret
