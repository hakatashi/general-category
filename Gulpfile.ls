require! {
  \gulp
  \gulp-mocha
  \gulp-livescript
}

gulp.task \livescript ->
  gulp.src <[*.ls test/*.ls !Gulpfile.ls]> base: \.
  .pipe gulp-livescript!
  .pipe gulp.dest \.

gulp.task \build-data <[livescript]> (done) ->
  require(\./build.js) done

gulp.task \build <[livescript build-data]>

gulp.task \test <[build]> ->
  gulp.src <[test/test.js]> {-read}
  .pipe gulp-mocha reporter: \spec

gulp.task \default <[build test]>
