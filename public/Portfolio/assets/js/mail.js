(function(){
    var app = angular.module('mail',[]);

    app.controller('mailCtrl', function($scope, $http){
        var urlServer = '/sendMail';

        $scope.sendMail = function(){
            $http.post(urlServer,{
                from: this.from,
                mail: this.addressMail,
                message: this.message
            })
            .success(function(data, status, headers, config){
                alert('L\'e-mail est envoyé!');
            })
            .error(function(data, status, headers, config){
                alert('L\'e-mail n\'a pas été envoyé!');
            });
            this.from = '';
            this.addressMail = '';
            this.message = '';
        };
    });
})();
