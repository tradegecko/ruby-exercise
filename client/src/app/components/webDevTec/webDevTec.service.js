(function() {
  'use strict';

  angular
      .module('angularRails')
      .service('webDevTec', webDevTec);

  /** @ngInject */
  function webDevTec() {
    var data = [
      {
        'title': 'Ruby on Rails',
        'url': 'https://angularjs.org/',
        'description': 'HTML enhanced for web apps!',
        'logo': 'Ruby_on_Rails-logo.png'
      },
      {
        'title': 'AngularJS',
        'url': 'https://http://rubyonrails.org/.org/',
        'description': 'Ruby on Rails makes web bulding much easier and fun',
        'logo': 'angular.png'
      },
      {
        'title': 'Angular Material Design',
        'url': 'https://material.angularjs.org/#/',
        'description': 'The Angular reference implementation of the Google\'s Material Design specification.',
        'logo': 'angular-material.png'
      },
      {
        'title': 'BrowserSync',
        'url': 'http://browsersync.io/',
        'description': 'Time-saving synchronised browser testing.',
        'logo': 'browsersync.png'
      },
      {
        'title': 'GulpJS',
        'url': 'http://gulpjs.com/',
        'description': 'The streaming build system.',
        'logo': 'gulp.png'
      },
      {
        'title': 'Yeoman',
        'url': 'http://yeoman.io/',
        'description': 'The modern web scaffolding',
        'logo': 'yeoman.png'
      }
    ];

    this.getTec = getTec;

    function getTec() {
      return data;
    }
  }

})();
