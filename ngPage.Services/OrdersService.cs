using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using ngPage.Models;
using ngPage.Database;

namespace ngPage.Services
{
    public class OrdersService:Base,IOrdersService
    {
        public int Id { get; set; }
        public string Fullname { get; set; }
        public int Quantity { get; set; }
        public int Price { get; set; }

        public OrdersService(IDataContext idatacontext):base(idatacontext)
        {
           
        }

        public List<Order> ReadAll(string keywords, ref int pageno, int pagesize, int blocksize, int orderby, int sortorder, ref int totalpages, ref int totalrecords)
        {
            List<Order> result = new List<Order>() { };

            var Keywords = new SqlParameter()
            {
                DbType = DbType.String,
                ParameterName = "Keywords",
                Value = string.IsNullOrEmpty(keywords) ? (object)DBNull.Value : keywords
            };

            var PageNo = new SqlParameter()
            {
                DbType = DbType.Int32,
                ParameterName = "PageNo",
                Direction = ParameterDirection.InputOutput,
                Value = pageno
            };

            var PageSize = new SqlParameter()
            {
                DbType = DbType.Int32,
                ParameterName = "PageSize",
                Value = pagesize
            };

            var BlockSize = new SqlParameter()
            {
                DbType = DbType.Int32,
                ParameterName = "BlockSize",
                Value = blocksize
            };

            var OrderBy = new SqlParameter()
            {
                DbType = DbType.Int32,
                ParameterName = "OrderBy",
                Value = orderby
            };

            var SortOrder = new SqlParameter()
            {
                DbType = DbType.Int32,
                ParameterName = "SortOrder",
                Value = sortorder
            };

            var TotalPages = new SqlParameter()
            {
                DbType = DbType.Int32,
                ParameterName = "TotalPages",
                Direction = ParameterDirection.Output
            };

            var TotalRecords = new SqlParameter()
            {
                DbType = DbType.Int32,
                ParameterName = "TotalRecords",
                Direction = ParameterDirection.Output
            };

            result = this.datacontext.Database.SqlQuery<Order>("EXEC Orders_ReadAllByKeywords @Keywords,@PageNo OUT,@PageSize,@BlockSize,@OrderBy,@SortOrder,@TotalPages OUT,@TotalRecords OUT", Keywords, PageNo, PageSize, BlockSize, OrderBy, SortOrder, TotalPages, TotalRecords).ToList<Order>();
            @totalpages = (int)TotalPages.Value;
            @totalrecords = (int)TotalRecords.Value;
            @pageno = (int)PageNo.Value;
            return result;
        }
    }
}
