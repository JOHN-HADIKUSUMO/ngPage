using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using ngPage.Models;
using ngPage.Database;
using ngPage.Services;

namespace ngPage.Controllers.Api
{
    [RoutePrefix("API/ORDERS")]
    public class OrdersController : Base
    {
        private IOrdersService service;
        public OrdersController(IDataContext datacontext, IOrdersService ordersService) :base(datacontext)
        {
            service = ordersService;
        }

        [AllowAnonymous]
        [AcceptVerbs("POST")]
        [Route("SEARCH")]
        public async Task<IHttpActionResult> Search(SearchOrders model)
        {
            HttpResponseMessage response;
            ViewOrders result = new ViewOrders();
            int selectedpageno = model.PageNo;
            int numberofrecords = 0;
            int numberofpages = 0;
            result.Orders= await Task.Run(()=> service.ReadAll(model.Keywords, ref selectedpageno, model.PageSize, model.BlockSize, model.OrderBy, model.SortOrder,ref numberofpages,ref numberofrecords));
            result.SelectedPageNo = selectedpageno;
            result.NumberOfRecords = numberofrecords;
            result.NumberOfPages = numberofpages;
            response = Request.CreateResponse<ViewOrders>(HttpStatusCode.OK, result);
            return ResponseMessage(response);
        }
    }
}
