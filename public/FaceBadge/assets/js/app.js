(function () {
 
    var app = angular.module('faceBadge', []);
    
    app.controller('FacesController', function ($scope, $http) {
        var urlServer = '/AutoLoc/face';
       
        //HTTP GET-> recup des données
        $http.get(urlServer).
        success(function (data, status, headers, config) {
            $scope.faces = data;
        })
        .error(function (data, status, headers, config) {
            alert('Erreur avec status: ' + status);
        });
    });
})();