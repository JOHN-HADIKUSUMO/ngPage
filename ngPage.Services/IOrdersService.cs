using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ngPage.Models;
using ngPage.Database;

namespace ngPage.Services
{
    public interface IOrdersService
    {
        List<Order> ReadAll(string keywords, ref int pageno, int pagesize, int blocksize, int orderby, int sortorder, ref int totalpages, ref int totalrecords);
    }
}
