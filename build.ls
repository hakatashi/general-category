module.exports = (done) ->
  require! {
    fs, path, async, 'gulp-util'
    'prelude-ls': {fold}
    'lodash.template': template
    './util.js': {integer-array-to-buffer, buffer-from}
    './categories.js': {long-names}
  }

  # Shim Buffer.from for older node versions
  # This polyfill not works for node v4, so we are skipping build on v4 only.
  Buffer.from = buffer-from

  unicodes =
    '1.1.5': -> require \unicode-1.1.5/General_Category
    '2.0.14': -> require \unicode-2.0.14/General_Category
    '2.1.2': -> require \unicode-2.1.2/General_Category
    '2.1.5': -> require \unicode-2.1.5/General_Category
    '2.1.8': -> require \unicode-2.1.8/General_Category
    '2.1.9': -> require \unicode-2.1.9/General_Category
    '3.0.0': -> require \unicode-3.0.0/General_Category
    '3.0.1': -> require \unicode-3.0.1/General_Category
    '3.1.0': -> require \unicode-3.1.0/General_Category
    '3.2.0': -> require \unicode-3.2.0/General_Category
    '4.0.0': -> require \unicode-4.0.0/General_Category
    '4.0.1': -> require \unicode-4.0.1/General_Category
    '4.1.0': -> require \unicode-4.1.0/General_Category
    '5.0.0': -> require \unicode-5.0.0/General_Category
    '5.1.0': -> require \unicode-5.1.0/General_Category
    '5.2.0': -> require \unicode-5.2.0/General_Category
    '6.0.0': -> require \unicode-6.0.0/General_Category
    '6.1.0': -> require \unicode-6.1.0/General_Category
    '6.2.0': -> require \unicode-6.2.0/General_Category
    '6.3.0': -> require \unicode-6.3.0/General_Category
    '7.0.0': -> require \unicode-7.0.0/General_Category
    '8.0.0': -> require \unicode-8.0.0/General_Category
    '9.0.0': -> require \unicode-9.0.0/General_Category

  # TODO: more neat sort algorithm
  versions = Object.keys unicodes .sort!

  sorted-category-names = Object.keys long-names .sort!

  reverse-long-names = sorted-category-names |> fold do
    (hash, item) -> hash[long-names[item]] = item; hash
    Object.create null

  # Returning data
  data = Object.create null

  gulp-util.log "Memory Usage: #{process.memory-usage!rss / (1024 * 1024) |> Math.floor}MiB"

  Object.keys unicodes .for-each (version) ->
    current-category = null
    category-data = []
    previous-codepoint = 0

    # node-unicode-data 0.2.0 seems to export Map object instead of the plain object hash.
    categories-iter = unicodes[version]!entries!

    gulp-util.log "Unicode data of version #version loaded."
    gulp-util.log "Memory Usage: #{process.memory-usage!rss / (1024 * 1024) |> Math.floor}MiB"

    # Iterates through codepoints and skip for compression if category is succeeding
    until (entry = categories-iter.next!).done
      [codepoint, category] = entry.value

      if current-category isnt category
        short-category = reverse-long-names[category]
        category-index = sorted-category-names.index-of short-category

        category-data.push codepoint - previous-codepoint
        category-data.push category-index

        current-category = category
        previous-codepoint = codepoint

    data[version] = category-data |> integer-array-to-buffer |> (.to-string \binary)

  data-length = JSON.stringify data .length
  gulp-util.log "Building category data finished. Size: #data-length bytes"

  var version-template

  async.series [
    # Initialize template
    (done) ->
      fs.read-file \version.js.template (error, data) ->
        return done error if error

        version-template := template data.to-string!
        done!

    # Create data directory if not exist
    (done) -> fs.access \data fs.F_OK, (error) ->
      if error
        fs.mkdir \data done
      else
        done!

    (done) -> async.parallel [
      # Write separated version to JSON file
      (done) -> async.for-each-of data, (category-data, version, done) ->
        async.parallel [
          (done) -> fs.write-file "data/#version.json" JSON.stringify(category-data), done

          (done) -> fs.write-file "#version.js", version-template({version}), done
        ], done
      , done

      # Create 'latest' submodule
      (done) ->
        version = versions[* - 1]
        new-data = "#version": data[version]

        fs.write-file \latest.js, version-template({version}), done
    ], done
  ], done
