(function() {
  'use strict';

  angular.module('angularRails')
    .controller('ArticlesController', function ($http, $mdSidenav, $mdToast, $log, Articles) {
      var vm = this;
      Articles.query(function (res) {
        vm.articles = res;
      });
       

    vm.showSuccess = function($event) {
      $mdToast.showSimple('Quote saved! May the luck be ever in your favor (to see it).');
    };


    vm.showError = function($event) {
      $mdToast.showSimple('Sorry... Something wrong with the Ruby guys. I will kick his ass!');
    };

    vm.showInvalid = function($event) {
      $mdToast.showSimple("Sorry. You quote's length should be from 0 - 140 characters");
    };

    function toggleUsersList() {
      $mdSidenav('left').toggle();
    }

    vm.toggleList = toggleUsersList;
    
    vm.submitForm = function(quote) {
      $log.debug("posting data....");
      $log.debug('toggle left is done');
      if (quote == null || quote.content == null || quote.content.length == 0 || quote.content.length > 140) {
        vm.showInvalid();
      } else {
        $http.post('/api/quotes', angular.toJson(quote)).success(function(){
          vm.showSuccess()
        }).error(function(){
          vm.showError()
        });
      }
     };
    });
})();
