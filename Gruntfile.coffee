module.exports = (grunt) ->

	require('load-grunt-tasks')(grunt)

	grunt.initConfig
		pkg: grunt.file.readJSON "package.json"

		paths:
			src:
				root: "src"
				images: "<%= paths.src.root %>/images"
				fonts: "<%= paths.src.root %>/fonts"
				styles: "<%= paths.src.root %>/styles"

			dist:
				root: "dist"
				images: "<%= paths.dist.root %>/images"
				fonts: "<%= paths.dist.root %>/fonts"

		snocketsify:
			app:
				src: "<%= paths.src.root %>/javascript.coffee"
				dest: "<%= paths.dist.root %>/app.js"

		uglify:
			production:
				files:
					"<%= paths.dist.root %>/app.min.js" : "<%= paths.dist.root %>/app.js"

		clean:
			dist: "<%= paths.dist.root %>"
			images: "<%= paths.dist.images %>"
			fonts: "<%= paths.dist.fonts %>"

		imagemin:
			compile:
				options:
					cache: false
				files: [
					expand: true
					cwd: "<%= paths.src.images %>"
					src: ["**/*.{png,jpg,gif}"]
					dest: "<%= paths.dist.images %>"
				]

		copy:
			images:
				expand: true
				cwd: "<%= paths.src.images %>"
				src: ["**/*.{png,jpg,gif}"]
				dest: "<%= paths.dist.images %>"

			fonts:
				expand: true
				cwd: "<%= paths.src.fonts %>"
				src: ["**/*"]
				dest: "<%= paths.dist.fonts %>"

		includereplace:
			html:
				options:
					prefix: "<!-- @@"
					suffix: " -->"
				files: [
					src: "**/*.html"
					dest: "<%= paths.dist.root %>/"
					expand: true
					cwd: "<%= paths.src.root %>/"
				]

		processhtml:
			options:
				process: true

			dev:
				expand: true
				cwd: "<%= paths.dist.root %>"
				src: ["**/*.html"]
				dest: "<%= paths.dist.root %>"

			production:
				expand: true
				cwd: "<%= paths.dist.root %>"
				src: ["**/*.html"]
				dest: "<%= paths.dist.root %>"

		autoprefixer:
			options:
				browsers: ["last 1 version", "> 1%", "ie 8", "ie 7"]

			compile:
				src: "<%= paths.dist.root %>/styles.css"
				dest: "<%= paths.dist.root %>/styles.css"

		cssmin:
			compile:
				files:
					"<%= paths.dist.root %>/styles.min.css": "<%= paths.dist.root %>/styles.css"

		compass:
			compile:
				options:
					cssDir:	"<%= paths.dist.root %>"
					sassDir:	"<%= paths.src.root %>"
					specify: "<%= paths.src.root %>/styles.scss"
					imagesDir: "<%= paths.dist.images %>"
					generatedImagesDir: "<%= paths.dist.images %>"
					fontsDir: "<%= paths.dist.fonts %>"
					outputStyle: "expanded"
					relativeAssets: true

		connect:
			server:
				options:
					port: 3000
					livereload: true

		watch:
			app:
				files: ["<%= paths.src.root %>/**/*.coffee"]
				tasks: ["app:dev"]
				options:
					livereload: true
			styles:
				files: ["<%= paths.src.root %>/styles.scss", "<%= paths.src.styles %>/**/*.scss"]
				tasks: ["styles:dev"]
				options:
					livereload: true
			html:
				files: ["<%= paths.src.root %>/**/*.html"]
				tasks: ["html:dev"]
				options:
					livereload: true
			images:
				files: ["<%= paths.src.images %>/**/*"]
				tasks: ["images"]
				options:
					livereload: true

	grunt.registerTask "images", ["clean:images", "copy:images"]
	grunt.registerTask "fonts", ["clean:fonts", "copy:fonts"]
	grunt.registerTask "html", ["includereplace:html", "processhtml:production"]
	grunt.registerTask "html:dev", ["includereplace:html", "processhtml:dev"]
	grunt.registerTask "app:dev", ["snocketsify:app"]
	grunt.registerTask "app:production", ["snocketsify:app", "uglify:production" ]
	grunt.registerTask "styles:dev", ["compass", "autoprefixer"]
	grunt.registerTask "styles:production", ["styles:dev", "cssmin"]

	grunt.registerTask "dev", ["clean:dist", "app:dev", "html:dev", "images", "fonts", "styles:dev"]
	grunt.registerTask "production", ["connect", "clean:dist", "app:production", "html", "imagemin", "styles:production"]
	grunt.registerTask "default", ["dev", "connect", "watch"]
