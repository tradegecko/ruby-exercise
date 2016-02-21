(function() {
  'use strict';

  angular
    .module('angularRails')
    .config(routerConfig);

  /** @ngInject */
  function routerConfig($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state('home', {
        url: '/~',
        templateUrl: 'app/components/credits/main.html',
        controller: 'MainController',
        controllerAs: 'main'
      })
      .state('quotes', {
        url: '/quotes',
        templateUrl: 'app/components/articles/articles.html',
        controller: 'ArticlesController',
        controllerAs: 'vm'
      })
      .state('new', {
        url: '/new',
        templateUrl: 'app/components/articles/articles_new.html',
        controller: 'ArticlesController',
        controllerAs: 'vm'

      })
      .state('aboutme', {
        url: '/aboutme',
        templateUrl: 'app/components/aboutme/aboutme.html'
      });

    $urlRouterProvider.otherwise('/quotes');
  }

})();
