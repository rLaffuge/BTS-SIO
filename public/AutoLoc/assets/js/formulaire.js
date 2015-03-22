(function () {

    var app = angular.module('Voiture', []);

    app.controller('carSavesCtrl', function ($scope, $http) {
        var urlServer = '/AutoLoc/vehicule';

        //HTTP GET-> recup des données
        $http.get(urlServer).
        success(function(data, status, headers, config) {
            $scope.carSaves = data;
        })
        .error(function(data, status, headers, config){
            alert('Erreur avec status: ' + status);
        });

        //HTTP POST-> ecriture dans la BDD
        $scope.addItem = function () {
            $http.post(urlServer,{
                idvehicule: null,
                immatriculation: this.carSave.immatriculation,
                dateMiseCirculation: this.carSave.dateMiseCirculation,
                marque: this.carSave.marque,
                modele: this.carSave.modele,
                energie: this.carSave.energie,
                releveKm: this.carSave.releveKm,
                prochaineRevisionKm: this.carSave.prochaineRevisionKm
            })
            .success(function(data, status, headers, config){
                $scope.carSaves.push(data);
                alert('Le produit a bien été ajouté!');
            })
            .error(function(data, status, headers, config){
                alert('Erreur avec status: ' + status);
            });
            $scope.carSave=[];
        };

        //HTTP DELETE-> suppression d'un produit
        $scope.removeItem = function(index){
            if(window.confirm('Voulez-vous vraiment supprimer le vehicule immatriculé ' + this.carSave.immatriculation + '?'))
            {
                $scope.carSaves.splice(index,1);
                var urlDelete = urlServer + '/' + this.carSave.idvehicule;
                $http.delete(urlDelete).error(function(data, status, headers, config){
                    alert('Erreur avec status: ' + status);
                });
            }
        };

        //HTTP PUT-> MAJ du produit
        $scope.updateItem = function(){
            var urlUpdate = urlServer + '/' + this.carSave.idvehicule;
            $http.put(urlUpdate,{
                immatriculation: this.carSave.immatriculation,
                dateMiseCirculation: this.carSave.dateMiseCirculation,
                marque: this.carSave.marque,
                modele: this.carSave.modele,
                energie: this.carSave.energie,
                releveKm: this.carSave.releveKm,
                prochaineRevisionKm: this.carSave.prochaineRevisionKm
            })
            .success(function(data, status, headers, config){
                alert('Le produit a bien été modifié!');
            })
            .error(function(data, status, headers, config){
                alert('Erreur avec status: ' + status);
            });
            //affichage du formulaire de POST
            $scope.setFormPost();
        };
        //selection du formulaire
        $scope.formUsed = true;
        $scope.setFormUpdate = function(){
            if ($scope.formUsed === true){
                $scope.formUsed = false;
                $scope.carSave = this.carSave;
                $scope.carSave.dateMiseCirculation = $scope.carSave.dateMiseCirculation.substr(0, 10);
            }
        };
        $scope.setFormPost = function(){
            if($scope.formUsed === false){
                $scope.formUsed = true;
                $scope.carSave = [];
            }
        };
    });
})();
