require! {
  \gulp
  \gulp-livescript
}

gulp.task \livescript ->
  gulp.src <[*.ls test/*.ls !Gulpfile.ls]> base: \.
  .pipe gulp-livescript!
  .pipe gulp.dest \.

gulp.task \build-data <[livescript]> (done) ->
  require(\./build.js) done

gulp.task \build <[livescript build-data]>

gulp.task \default <[build]>
