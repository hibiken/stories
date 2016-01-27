angular.module("Stories", [])
  .controller("AutocompleteCtrl", ["$scope", "$http", function($scope, $http) {
    $scope.searchTerm = "";

    $scope.$watch("searchTerm", function(newVal, oldVal) {
      if ( newVal !== oldVal ) {
        $http.get('/autocomplete.json?term=' + $scope.searchTerm)
          .success(function(data) {
            // console.log(data);
            $scope.posts = data["posts"];
            $scope.users = data["users"];
            console.log($scope.posts);
            console.log($scope.users);
          });
      }
    });
  }]);
