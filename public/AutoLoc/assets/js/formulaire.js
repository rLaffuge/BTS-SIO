(function () {

    var app = angular.module('Voiture', []);

    app.controller('carSavesCtrl', function ($scope, $http) {
        var urlServer = '/AutoLoc/vehicule';

        //Variable permettant de selectionner le formulaire initialisé à POST
        var legend = ['Ajout d\'un véhicule', 'Modification d\'un véhicule'];
        var form= ['formPOST', 'formPUT'];
        $scope.formSelected = form[0];
        $scope.legend = legend[0];

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
            $scope.formToggle();
        };
        
        //HTTP DELETE-> suppression d'un produit
        $scope.removeItem = function (index) {
            if (window.confirm('Voulez-vous vraiment supprimer le vehicule immatriculé ' + this.carSave.immatriculation + '?')) {
                $scope.carSaves.splice(index, 1);
                var urlDelete = urlServer + '/' + this.carSave.idvehicule;
                $http.delete(urlDelete).error(function (data, status, headers, config) {
                    alert('Erreur avec status: ' + status);
                });
            }
        };
        
        //Selection du formulaire
        $scope.selectForm = function () {
            if ($scope.formSelected == 'formPOST') {
                $scope.addItem();
            } else if ($scope.formSelected == 'formPUT') {
                $scope.updateItem();
            }
        };

        //Changement du formulaire
        $scope.formToggle = function () {
            if ($scope.formSelected == form[0]) {
                $scope.formSelected = form[1];
                $scope.legend = legend[1];
                $scope.carSave = this.carSave;
                $scope.carSave.dateMiseCirculation = $scope.carSave.dateMiseCirculation.substr(0, 10);
            } else {
                $scope.formSelected = form[0];
                $scope.legend = legend[0];
                $scope.carSave = [];
                $scope.carSave.energie = 'diesel';
            }
        };
    });
})();
