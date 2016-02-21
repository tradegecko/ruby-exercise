(function() {
  'use strict';

  angular.module('angularRails')
    .controller('ArticlesController', function ($scope, $http, $mdToast, Articles) {

      Articles.query(function (res) {
        $scope.articles = res;
      });
       
      $scope.showSuccess = function($event) {
	    $mdToast.showSimple('Quote saved! May the luck be ever in your favor (to see it).');
	  };

	  $scope.showError = function($event) {
	    $mdToast.showSimple('Sorry... Something wrong with the Ruby guys. I will kick his ass!');
	  };

	  $scope.showInvalid = function($event) {
	    $mdToast.showSimple("Sorry. You quote's length should be from 0 - 140 characters");
	  };

      $scope.submitForm = function(quote) {
        console.log("posting data....");
        console.log(quote)
        if (quote == null || quote.content == null || quote.content.length == 0 || quote.content.length > 140) {
        	$scope.showInvalid();
        } else {
	        $http.post('/api/quotes', JSON.stringify(quote)).success(function(){
	        	var result = quote.content + " ~ " + quote.author + " #" + quote.hashtags
	        	$scope.showSuccess()
	        }).error(function(){
	        	$scope.showError()
	        });
        }
       };
    });
})();
