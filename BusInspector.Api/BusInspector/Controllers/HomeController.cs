

using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.Mvc;

namespace BusInspector.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        public ActionResult Index()
       {            
            return View();
        }
    }
}

