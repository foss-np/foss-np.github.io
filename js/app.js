function mainCtrl($scope,$rootScope,$http){
	$http.get('https://api.github.com/orgs/foss-np/repos').success(function(data){
		$scope.repos = data;
	})
}
