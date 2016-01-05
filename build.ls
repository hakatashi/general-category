module.exports = (done) ->
  require! fs

  unicodes =
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

  # Write out to JSON file
  fs.write-file \data.json JSON.stringify(data), done
