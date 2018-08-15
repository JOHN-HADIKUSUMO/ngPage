# ngPage
<MTMarkdownOptions output='raw'>
The running example can be seen on http://ngpage.satuindonesia.com.au. There are three files needed in order to run this pagination module :
<table border="0" cellpadding="0" cellspacing="0" style="border:solid #1px #000000;">
<tr>
    <td>
        - ngPage.js    
    </td>
</tr>
<tr>
    <td>
        - ngPage.html
    </td>
</tr>
<tr>
    <td>
        - ngPage.css
    </td>
</tr>
</table>
</MTMarkdownOptions>

```
<div class="col-md-12 margin-bottom-50">
     <pagination selectedpageno="parameters.selectedpageno" numberofrecords="parameters.numberofrecords" numberofpages="parameters.numberofpages" itemsperpage="parameters.itemsperpage" pagesperblock="parameters.pagesperblock" on-click="onPageClick(id)">
     </pagination>
</div>
```
