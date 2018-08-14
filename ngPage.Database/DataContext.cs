using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Data.Entity.Validation;

namespace ngPage.Database
{
    public class DataContext:DbContext,IDataContext
    {
        public DataContext():base("DefaultConnection")
        {

        }
    }
}