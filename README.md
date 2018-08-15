# ngPage
<MTMarkdownOptions output='raw'>
The running example can be seen on http://ngpage.satuindonesia.com.au. There are three files needed in order to implement this pagination module on your html page :

* ngPage.js    
* ngPage.html
* ngPage.css


Include **ngPage** module on your angular module :

```
var apps = angular.module('apps', ['ui.bootstrap','ngPage']);
```

You also need to provide **$scope.parameters** with five properties as shown below. The code below is taken from the sample code **apps.js**, you might want to assign the values directly as you wish. The **ngPage** 

```
$scope.parameters = {
     selectedpageno: data.SelectedPageNo,
     numberofpages: data.NumberOfPages,
     numberofrecords: data.NumberOfRecords,
     itemsperpage: $scope.pagesize,
     pagesperblock: $scope.blocksize
};
```

Or

```
$scope.parameters = {
     selectedpageno: 1,
     numberofpages: 100,
     numberofrecords: 1000,
     itemsperpage: 10,
     pagesperblock: 10
};
```

You need to add a method on your module to pick up the selected page no as the user clicks on the pagination buttons. The name
of the method can be anything but it should has one numerical parameters. In this case we call it **onPageClick** method.

```
$scope.onPageClick = function (n) {};

```

```
<div class="col-md-12 margin-bottom-50">
     <pagination selectedpageno="parameters.selectedpageno" numberofrecords="parameters.numberofrecords" numberofpages="parameters.numberofpages" itemsperpage="parameters.itemsperpage" pagesperblock="parameters.pagesperblock" on-click="onPageClick(id)">
     </pagination>
</div>
```
