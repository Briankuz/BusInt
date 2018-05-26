using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using System.IO;


namespace BusInspector.Web.Controllers
{
	public class AdministracionController: Controller
	{


		public ActionResult Home()
		{
			if (Session["IdUsuario"] == null)
			{
				TempData["urlController"] = Request.RequestContext.RouteData.Values["controller"].ToString();
				TempData["urlAction"] = Request.RequestContext.RouteData.Values["action"].ToString();
				return RedirectToAction("Login", "Home");
			}
			return View();
		}
	}
}