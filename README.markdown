# Plain HTML/Sass/CoffeeScript front-end starter kit

## First steps

* Make sure you remove `.git/` folder, because you would like to have your own
	versioning, isn't it?
* Install needed NPM packages for dev purposes: `npm install`
* Remember that you should have Grunt, Bower and some other NPM packages
	installed globally
* Install project dependencies: `bower install`
* Install [Ruby](https://www.ruby-lang.org/en/downloads "Download Ruby"),
	[Sass](http://sass-lang.com/install "Sass: Install Sass"), and
	[Compass](http://compass-style.org/install "Install the Compass Stylesheet Authoring Framework")
* Run your Grunt default task: `grunt`
* Open your browser and your editor and start coding:
	`http://localhost:3000/dist/`

## Grunt tasks

* `grunt`: Default task. Executes `grunt dev` (see next point), launch an HTTP server on port `3000` and watch for changes on files
* `grunt dev`: Compiles source files for dev purposes (without minification…)
* `grunt production`: Compiles source files for production (minification, concatenates into single JS and CSS files…)
