/* Main Module */
var apps = angular.module('apps', ['ui.bootstrap','ngPage']);

var ordersCtrl = apps.controller("ordersCtrl", ['$scope', 'ordersSvc', function ($scope, ordersSvc) {
    $scope.pageno = 1;
    $scope.pagesize = 10;
    $scope.blocksize = 10;
    $scope.sortbylist = [
        {
            id: 0,
            label: 'Id'
        },
        {
            id: 1,
            label: 'Fullname'
        },
        {
            id: 2,
            label: 'Product'
        },
        {
            id: 3,
            label: 'Quantity'
        },
        {
            id: 4,
            label: 'Price'
        }
    ];
    $scope.orderby = { id: 0, label: 'Id' };
    $scope.isprogressing = false;
    $scope.onPageClick = function (n) {
        $scope.pageno = n;
        $scope.search();
    };
    $scope.changeClick = function () {
        $scope.search();
    };
    $scope.goClick = function () {
        $scope.search();
    };
    this.$onInit = function () {
        $scope.search();
    };
    $scope.orders = [];
    $scope.enterClick = function (e) {
        if (e == 13) {
            $scope.search();
        }
    };
    $scope.parameters = null;
    $scope.search = function () {
        $scope.isprogressing = true;
        var data = {
            Keywords: $scope.keywords,
            PageNo: $scope.pageno,
            PageSize: $scope.pagesize,
            BlockSize: $scope.blocksize,
            OrderBy: $scope.orderby.id,
            SortOrder: 0
        };
        ordersSvc.search(data)
        .then(function (response) {
            var data = response.data;
            $scope.orders = [];

            for (var i = 0; i < data.Orders.length; i++) {
                $scope.orders.push(data.Orders[i]);
            }

            $scope.parameters = {
                selectedpageno: data.SelectedPageNo,
                numberofpages: data.NumberOfPages,
                numberofrecords: data.NumberOfRecords,
                itemsperpage: $scope.pagesize,
                pagesperblock: $scope.blocksize
            };
        })
        .catch(function (response) { })
        .finally(function () {
            $scope.isprogressing = false;
        });
    };
    this.$onInit = function () {
        $scope.search();
    };
}]);


var ordersSvc = apps.factory('ordersSvc', ['$http', function ($http) {
    var ordersSvc = {
        search: function (data) {
            return $http.post('/API/ORDERS/SEARCH', data);
        }
    };
    return ordersSvc;
}]);
