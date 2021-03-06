module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)
  path = require('path')
  pkg = grunt.file.readJSON("package.json")

  DEBUG = false # 添加测试所需代码，发布时应该为false

  grunt.initConfig
    pkg: pkg

    changelog:
      options:
        dest: "CHANGELOG.md"
        template: "changelog.tpl"

    bump:
      options:
        files: ["package.json", "bower.json"]
        commit: true
        commitMessage: "chore(release): v%VERSION%"
        commitFiles: ["-a"]
        createTag: true
        tagName: "v%VERSION%"
        tagMessage: "Version %VERSION%"
        push: true
        pushTo: "origin"

    clean:
      bin:
        dot: true
        files:
          src: [
            "bin/*"
            ".temp"
          ]

    copy:
      appCode:
        files: [
          src: ["**/*.*", "!**/**.{ls,sass}"]
          dest: "bin/"
          cwd: "src/"
          expand: true
        ]

    concat:
      build_css:
        src: [
          "bin/**/*.css"
          "!bin/<%= pkg.name %>*.css"
          "!bin/vendor/**/*.css"
          "!bin/tests/**/*.css"
          "!bin/**/debug.css"
        ]
        dest: "bin/<%= pkg.name %>-<%= pkg.version %>.css"

    livescript:
      options:
        bare: false
      all:
        expand: true
        # flatten: true
        cwd: "src/"
        src: ['**/**.ls']
        dest: "bin/"
        ext: ".js"

    # sass:
    #   options:
    #     includePaths: require('node-bourbon').with('src/common/sass')
    #   build:
    #     files: [
    #       src: ["**/*.sass"]
    #       dest: "bin/"
    #       cwd: "src/"
    #       expand: true
    #       ext: ".css"
    #     ]

    express:
      dev:
        options:
          server: 'bin/server.js'
          # bases: 'bin/public'
          # livereload: true
          # serverreload: false
          port: 3000
          showStack: true

    delta:
      options:
        livereload: false

      livescript:
        files: ["src/public/**/*.*", "src/views/**/*.*"]
        tasks: ["livescript"]

      # sass:
      #   files: ["src/**/*.sass"]
      #   tasks: ["sass", "concat"]

      appCode:
        files: ["src/**/*.*", "!src/**/**.{ls,sass}"]
        tasks: ["copy:appCode"]

      express:
        files: ["bin/public/**/*.*", "bin/views/**/*.*"]
        tasks: []
        options:
          livereload: true
          showStack: true

      grunt:
        files: ['Gruntfile.coffee']


  grunt.renameTask "watch", "delta"

  grunt.registerTask "watch", [
    "clean"
    "build"
    "express"
    "delta"
  ]

  grunt.registerTask "default", [
    "build"
  ]

  grunt.registerTask "build", [
    "livescript"
    # "sass"
    "copy"
  ]