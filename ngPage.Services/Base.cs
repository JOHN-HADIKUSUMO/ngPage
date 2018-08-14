using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ngPage.Database;

namespace ngPage.Services
{
    public abstract class Base:IDataContext
    {
        protected DataContext datacontext;
        public Base(IDataContext idatacontext)
        {
            datacontext = (DataContext)idatacontext;
        }
    }
}
