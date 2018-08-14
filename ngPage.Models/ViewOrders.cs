using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ngPage.Models
{
    public class ViewOrders
    {
        public List<Order> Orders { get; set; }
        public int SelectedPageNo { get; set; }
        public int NumberOfPages { get; set; }
        public int NumberOfRecords { get; set; }
    }
}
