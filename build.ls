module.exports = (done) ->
  require! {
    fs, path, async, 'gulp-util'
    'lodash.template': template
    './util.js': {integer-array-to-buffer}
    './categories.js': {long-names}
  }

  unicodes =
    '1.1.5': require \unicode-1.1.5/categories
    '2.0.14': require \unicode-2.0.14/categories
    '2.1.2': require \unicode-2.1.2/categories
    '2.1.5': require \unicode-2.1.5/categories
    '2.1.8': require \unicode-2.1.8/categories
    '2.1.9': require \unicode-2.1.9/categories
    '3.0.0': require \unicode-3.0.0/categories
    '3.0.1': require \unicode-3.0.1/categories
    '3.1.0': require \unicode-3.1.0/categories
    '3.2.0': require \unicode-3.2.0/categories
    '4.0.0': require \unicode-4.0.0/categories
    '4.0.1': require \unicode-4.0.1/categories
    '4.1.0': require \unicode-4.1.0/categories
    '5.0.0': require \unicode-5.0.0/categories
    '5.1.0': require \unicode-5.1.0/categories
    '5.2.0': require \unicode-5.2.0/categories
    '6.0.0': require \unicode-6.0.0/categories
    '6.1.0': require \unicode-6.1.0/categories
    '6.2.0': require \unicode-6.2.0/categories
    '6.3.0': require \unicode-6.3.0/categories
    '7.0.0': require \unicode-7.0.0/categories
    '8.0.0': require \unicode-8.0.0/categories

  # TODO: more neat sort algorithm
  versions = Object.keys unicodes .sort!

  sorted-category-names = Object.keys long-names .sort!

  # Returning data
  data = Object.create null

  for version, categories of unicodes
    current-category = null
    category-data = []
    previous-codepoint = 0

    # node-unicode-data 0.2.0 seems to export Map object instead of the plain object hash.
    categories-iter = categories.entries!

    # Iterates through codepoints and skip for compression if category is succeeding
    until (entry = categories-iter.next!).done
      [codepoint, category] = entry.value

      if current-category isnt category
        category-index = sorted-category-names.index-of category

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
      # Write out to JSON file
      (done) -> fs.write-file \data/index.json JSON.stringify(data), done

      # Write separated version to JSON file
      (done) -> async.for-each-of data, (category-data, version, done) ->
        new-data = "#version": category-data

        async.parallel [
          (done) -> fs.write-file "data/#version.json" JSON.stringify(new-data), done

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
