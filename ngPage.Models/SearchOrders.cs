using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ngPage.Models
{
    public class SearchOrders
    {
        public string Keywords { get; set; }
        public int PageNo { get; set; }
        public int PageSize { get; set; }
        public int BlockSize { get; set; }
        public int OrderBy { get; set; }
        public int SortOrder { get; set; }
    }
}
