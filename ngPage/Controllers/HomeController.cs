using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ngPage.Models;
using ngPage.Database;
using ngPage.Services;

namespace ngPage.Controllers
{
    public class HomeController : Controller
    {
        private DataContext datacontext;
        public HomeController(IDataContext idatacontext)
        {
            datacontext = (DataContext)idatacontext;
        }

        public ActionResult Index()
        {
            ViewBag.Title = "ngPage";
            return View();
        }
    }
}