require! fs

unicodes =
  '8.0.0': require \unicode-8.0.0/categories

data = Object.create null

for version, categories of unicodes
  current-category = null
  category-data = Object.create null

  for category, codepoint in categories
    if current-category isnt category
      category-data[codepoint] = category
      current-category = category

  data[version] = category-data

fs.write-file \data.json JSON.stringify data
