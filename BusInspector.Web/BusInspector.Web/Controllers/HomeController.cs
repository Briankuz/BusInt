
using BusInspector.Dal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.Mvc;


namespace BusInspector.Web.Controllers
{
	public class HomeController : Controller
	{
		// GET: Home
		public ActionResult Index()
		{
			return View();
		}

		public ActionResult Login()
		{
			return View();
		}

		[HttpPost]
		public ActionResult Login(Usuarios usuario)
		{
			if (ModelState.IsValid)
			{
				using (MyContext ctx = new MyContext())
				{
					var query = (from re in ctx.Usuarios select re).ToList();

					foreach (Usuarios user in query)
					{
						user.NombreUsuario = usuario.NombreUsuario;
						user.Password = usuario.Password;
					}
					var log = ctx.Usuarios.Where(a => a.NombreUsuario.Equals(usuario.NombreUsuario) && a.Password.Equals(usuario.Password)).FirstOrDefault();
					if (log != null)
					{
						Session["IdUsuario"] = log.IdUsuario.ToString();
						Session["NombreUsuario"] = log.NombreUsuario;

						// Verifico de que vista viene, en caso de que sea null significa que esta ingresando desde el index
						if (TempData["urlAction"] == null)
						{ return RedirectToAction("Home", "Administracion"); }

						return RedirectToAction(TempData["urlAction"].ToString(), TempData["urlController"].ToString());
					}
					else
					{
						TempData["Error"] = "Usuario o contraseña incorrecta";
					}
				}
			}
			return RedirectToAction("Login", "Home");

		}




		public ActionResult DespuesDelLogin()
		{
			if (Session["IdUsuario"] != null)
			{
				return View();
			}
			else
			{
				return RedirectToAction("Inicio");
			}

		}

		public ActionResult Logout()
		{
			Session.Clear();
			return RedirectToAction("Login", "Home");

		}

	}
}