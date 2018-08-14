using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using ngPage.Database;

namespace ngPage.Controllers.Api
{
    public abstract class Base: ApiController, IDataContext
    {
        protected DataContext datacontext;
        public Base(IDataContext idatacontext)
        {
            datacontext = (DataContext)idatacontext;
        }
    }
}
