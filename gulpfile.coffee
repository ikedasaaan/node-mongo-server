gulp   = require 'gulp'
gutil  = require 'gulp-util'
coffee = require 'gulp-coffee'
jade   = require 'gulp-jade';
less   = require 'gulp-less'
server = require 'gulp-express'
clean  = require 'gulp-clean'

gulp.task 'compile-coffee', () ->
  gulp.src ['client/javascripts/*.coffee']
    .pipe coffee()
    .pipe gulp.dest('public/javascripts')

gulp.task 'compile-jade', () ->
  gulp.src('client/*.jade')
    .pipe(jade())
    .pipe gulp.dest('public')

gulp.task 'compile-less', () ->
  gulp.src('client/stylesheets/*.less')
    .pipe(less())
    .pipe gulp.dest('public/stylesheets')

gulp.task 'server', ['compile'], () ->
  
  #start the server at the beginning of the task
  server.run file: './bin/www'
  
  #restart the server when file changes
  gulp.watch [
    'bin/www'
    'app.coffee'
    'config/*.json'
    'routes/*.coffee'
    'server/*.coffee'
    'server/common/*.coffee'
    'server/admin/*.coffee'
    'server/user/*.coffee'
    'server/api/*.coffee'
    'views/*.jade'
    'client/javascripts/*.coffee'
    'client/stylesheets/*.less'
  ], [server.run]
  gulp.watch [
    'public/javascripts/*.js'
    'public/stylesheets/*.css'
  ], server.notify

gulp.task 'clean', ->
  gulp.src 'public/*.html', {read:false}
    .pipe clean()
  gulp.src 'public/javascripts/*.js', {read:false}
    .pipe clean()
  gulp.src 'public/stylesheets/*.css', {read:false}
    .pipe clean()
  gulp.src 'logs/*.log', {read:false}
    .pipe clean()

gulp.task 'compile', ['compile-coffee', 'compile-jade', 'compile-less']
gulp.task 'default', ['server']
