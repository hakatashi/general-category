module.exports = (done) ->
  require! {fs, path, async}

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

  # Returning data
  data = Object.create null

  for version, categories of unicodes
    current-category = null
    category-data = Object.create null

    # Iterates through codepoints and skip for compression if category is succeeding
    for category, codepoint in categories
      if current-category isnt category
        category-data[codepoint] = category
        current-category = category

    data[version] = category-data

  async.series [
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
        ], done
      , done
    ], done
  ], done
