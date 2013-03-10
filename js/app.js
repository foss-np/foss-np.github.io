var fossnp = angular.module('fossnp',[]);

fossnp.config(function($routeProvider) {
	$routeProvider.when('/repo/:repo/:owner',{templateUrl:'contributor.html',controller:repoCtrl})
});

function mainCtrl($scope, $rootScope, $http, $route, $location, $routeParams){
	$http.get('https://api.github.com/orgs/foss-np/repos').success(function(data){
		$rootScope.repos = data;
	});
	$scope.$route = $route;
	$scope.$location = $location;
	$scope.$routeParams = $routeParams;
}

function repoCtrl($scope, $http, $routeParams){
	console.log('hello World');
	$http.get('https://api.github.com/repos/'+$routeParams.owner+'/'+$routeParams.repo+'/contributors').success(function(data){
		$scope.contributors = data;
	});
}
