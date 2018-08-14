var ngPage = angular.module('ngPage', ['ui.bootstrap']);
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
            'parameters': '=',
            onClick: '&'
        },
        link: function (scope, element, attrs) {
            scope.$watch("parameters", function (obj) {
                if (obj != null) {
                    var getnavigation = function (params) {
                        var result = {
                            first:null,
                            prev: null,
                            itemlist: [],
                            next: null,
                            last: null
                        };

                        var numberofitems = params.numberofrecords;
                        var numberofpages = params.numberofpages;
                        var numberofitemsperpage = params.itemsperpage;
                        var numberofpagesperblock = params.pagesperblock;
                        var numberofblocks = 1;
                        var selectedblockno = 1;
                        var selectedpageno = params.selectedpageno;

                        if(numberofitems <= numberofitemsperpage)
                        {
                            numberofblocks = 1;
                        }
                        else
                        {
                            if(numberofpages <= numberofpagesperblock)
                            {
                                numberofblocks = 1;
                            }
                            else
                            {
                                numberofblocks = Math.abs(Math.floor(numberofpages / numberofpagesperblock));
                                if(numberofblocks % numberofpagesperblock > 0)
                                {
                                    numberofblocks++;
                                }
                            }
                        }

                        if(selectedpageno > numberofpages)
                        {
                            selectedpageno = numberofpages;
                        }
                        
                        if(selectedpageno <= numberofpagesperblock)
                        {
                            selectedblockno = 1;
                        }
                        else
                        {
                            selectedblockno = Math.abs(Math.floor(selectedpageno / numberofpagesperblock));
                            if(selectedpageno % numberofpagesperblock > 0)
                            {
                                selectedblockno++;
                            }
                        }

                        var start_page = ((selectedblockno - 1) * numberofpagesperblock) + 1;
                        var stop_page = selectedblockno * numberofpagesperblock;
                        if (stop_page > numberofpages) stop_page = numberofpages;

                        for(var i=start_page;i<=stop_page;i++)
                        {
                            result.itemlist.push(i);
                        }

                        if(numberofblocks == 1)
                        {
                            result.first = null;
                            result.prev = null;
                            result.next = null;
                            result.last = null;
                        }
                        else
                        {
                            if (selectedblockno == numberofblocks)
                            {
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
                            else
                            {
                                result.first = 1;
                                result.prev = selectedpageno - 1;
                                result.next = selectedpageno + 1;
                                result.last = numberofpages;
                            }
                        }
                        return result;
                    };
                    var page = element.find('#pagination');
                    page.html('');
                    var navs = getnavigation(obj);
                    if (navs.first != null)
                    {
                        var button = angular.element('<button ng-click="click(' + navs.first + ')">First</button>');
                        page.append(button);
                        $compile(button)(scope);
                    }
                    if (navs.prev != null) {
                        var button = angular.element('<button ng-click="click(' + navs.prev + ')">Prev</button>');
                        page.append(button);
                        $compile(button)(scope);
                    }
                    for (var i = 0; i < navs.itemlist.length; i++) {
                        var button = null;
                        if (navs.itemlist[i] == obj.selectedpageno)
                        {
                            button = angular.element('<span>&nbsp;&nbsp;' + navs.itemlist[i] + '&nbsp;&nbsp;</span>');
                        }
                        else
                        {
                            button = angular.element('<button ng-click="click(' + navs.itemlist[i] + ')">' + navs.itemlist[i] + '</button>');
                        }
                        page.append(button);
                        $compile(button)(scope);
                    }
                    if (navs.next != null) {
                        var button = angular.element('<button ng-click="click(' + navs.next + ')">Next</button>');
                        page.append(button);
                        $compile(button)(scope);
                    }
                    if (navs.last != null) {
                        var button = angular.element('<button ng-click="click(' + navs.last + ')">Last</button>');
                        page.append(button);
                        $compile(button)(scope);
                    }
                };
            });
        },
    };
}]);
