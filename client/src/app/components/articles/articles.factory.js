(function() {
  'use strict';

  angular.module('angularRails')
    .factory('Articles', function ($resource) {
      return $resource('api/quotes/:articleId', {
        articleId: '@id'
      }, {
        update: {
          method: 'PUT'
        }
      });
    });
})();
