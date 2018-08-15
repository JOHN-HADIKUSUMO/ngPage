# ngPage
<MTMarkdownOptions output='raw'>
The running example can be seen on http://ngpage.satuindonesia.com.au. There are three files needed in order to implement this pagination module on your html page :

* ngPage.js    
* ngPage.html
* ngPage.css

Make sure you have included those files on your html page.

```
<div class="col-md-12 margin-bottom-50">
     <pagination selectedpageno="parameters.selectedpageno" numberofrecords="parameters.numberofrecords" numberofpages="parameters.numberofpages" itemsperpage="parameters.itemsperpage" pagesperblock="parameters.pagesperblock" on-click="onPageClick(id)">
     </pagination>
</div>
```
