﻿var ngPage = angular.module('ngPage', ['ui.bootstrap']);
var pagination = ngPage.directive('pagination', ['$filter', '$compile', function ($filter, $compile) {
    var paginationCtl = function ($scope) {
        $scope.click = function (n) {
            $scope.onClick({ id: n });
        };
    };

    return {
        restrict: 'AE',
        replace: 'true',
        templateUrl: '/scripts/ngPage/ngPage.html',
        controller: paginationCtl,
        scope: {
            'selectedpageno': '=',
            'numberofrecords': '=',
            'numberofpages': '=',
            'itemsperpage': '=',
            'pagesperblock': '=',
            onClick: '&'
        },
        link: function (scope, element, attrs) {
            var getnavigation = function (selectedpageno, numberofrecords, numberofpages, itemsperpage, pagesperblock) {
                var result = {
                    first: null,
                    prev: null,
                    itemlist: [],
                    next: null,
                    last: null
                };

                var numberofitems = numberofrecords;
                var numberofpages = numberofpages;
                var numberofitemsperpage = itemsperpage;
                var numberofpagesperblock = pagesperblock;
                var numberofblocks = 1;
                var selectedblockno = 1;
                var selectedpageno = selectedpageno;

                if (numberofitems <= numberofitemsperpage) {
                    numberofblocks = 1;
                }
                else {
                    if (numberofpages <= numberofpagesperblock) {
                        numberofblocks = 1;
                    }
                    else {
                        numberofblocks = Math.abs(Math.floor(numberofpages / numberofpagesperblock));
                        if (numberofblocks % numberofpagesperblock > 0) {
                            numberofblocks++;
                        }
                    }
                }

                if (selectedpageno > numberofpages) {
                    selectedpageno = numberofpages;
                }

                if (selectedpageno <= numberofpagesperblock) {
                    selectedblockno = 1;
                }
                else {
                    selectedblockno = Math.abs(Math.floor(selectedpageno / numberofpagesperblock));
                    if (selectedpageno % numberofpagesperblock > 0) {
                        selectedblockno++;
                    }
                }

                var start_page = ((selectedblockno - 1) * numberofpagesperblock) + 1;
                var stop_page = selectedblockno * numberofpagesperblock;
                if (stop_page > numberofpages) stop_page = numberofpages;

                for (var i = start_page; i <= stop_page; i++) {
                    result.itemlist.push(i);
                }

                if (numberofblocks == 1) {
                    result.first = null;
                    result.prev = null;
                    result.next = null;
                    result.last = null;
                }
                else {
                    if (selectedblockno == numberofblocks) {
                        result.first = 1;
                        result.prev = selectedpageno - 1;
                        result.next = null;
                        result.last = null;
                    }
                    else if (selectedblockno == 1) {
                        result.first = null;
                        result.prev = null;
                        result.next = selectedpageno + 1;
                        result.last = numberofpages;
                    }
                    else {
                        result.first = 1;
                        result.prev = selectedpageno - 1;
                        result.next = selectedpageno + 1;
                        result.last = numberofpages;
                    }
                }
                return result;
            };

            var process = function (selectedpageno, numberofrecords, numberofpages, itemsperpage, pagesperblock) {
                var page = element.find('#pagination');
                page.html('');
                var navs = getnavigation(selectedpageno, numberofrecords, numberofpages, itemsperpage, pagesperblock);
                if (navs.first != null) {
                    var button = angular.element('<a href="#" class="notselected" ng-click="click(' + navs.first + ')">First</a>');
                    page.append(button);
                    $compile(button)(scope);
                }
                if (navs.prev != null) {
                    var button = angular.element('<a href="#" class="notselected" ng-click="click(' + navs.prev + ')">Prev</a>');
                    page.append(button);
                    $compile(button)(scope);
                }
                for (var i = 0; i < navs.itemlist.length; i++) {
                    var button = null;
                    if (navs.itemlist[i] == selectedpageno) {
                        button = angular.element('<span class="selected">' + navs.itemlist[i] + '</span>');
                    }
                    else {
                        button = angular.element('<a href="#" class="notselected" ng-click="click(' + navs.itemlist[i] + ')">' + navs.itemlist[i] + '</button>');
                    }
                    page.append(button);
                    $compile(button)(scope);
                }
                if (navs.next != null) {
                    var button = angular.element('<a href="#" class="notselected" ng-click="click(' + navs.next + ')">Next</a>');
                    page.append(button);
                    $compile(button)(scope);
                }
                if (navs.last != null) {
                    var button = angular.element('<a href="#" class="notselected" ng-click="click(' + navs.last + ')">Last</a>');
                    page.append(button);
                    $compile(button)(scope);
                }
            };

            scope.$watch("selectedpageno", function (n) {
                process(n, scope.numberofrecords, scope.numberofpages, scope.itemsperpage, scope.pagesperblock);
            });
            scope.$watch("numberofrecords", function (n) {
                process(scope.selectedpageno, n, scope.numberofpages, scope.itemsperpage, scope.pagesperblock);
            });
            scope.$watch("numberofpages", function (n) {
                process(scope.selectedpageno, scope.numberofrecords, n, scope.itemsperpage, scope.pagesperblock);
            });
            scope.$watch("itemsperpage", function (n) {
                process(scope.selectedpageno, scope.numberofrecords, scope.numberofpages, n, scope.pagesperblock);
            });
            scope.$watch("pagesperblock", function (n) {
                process(scope.selectedpageno, scope.numberofrecords, scope.numberofpages, scope.itemsperpage, n);
            });
        },
    };
}]);
