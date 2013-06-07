var fossnp = angular.module('fossnp',[]);

fossnp.config(function($routeProvider) {
	$routeProvider.when('/repo/:repo/:owner',{templateUrl:'contributor.html',controller:repoCtrl})
});

function mainCtrl($scope, $rootScope, $http, $route, $location, $routeParams){
	$http.jsonp('https://api.github.com/orgs/foss-np/repos?callback=JSON_CALLBACK').success(function(data){
		$rootScope.repos = data.data;
	});
	$scope.$route = $route;
	$scope.$location = $location;
	$scope.$routeParams = $routeParams;
}

function repoCtrl($scope, $http, $routeParams){
	$http.jsonp('https://api.github.com/repos/'+$routeParams.owner+'/'+$routeParams.repo+'/contributors?callback=JSON_CALLBACK').success(function(data){
		$scope.contributors = data.data;
	});
}
