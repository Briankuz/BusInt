using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusInspector.Dal;
using BusInspector.Web.Models;

namespace BusInspector.Web.Controllers
{
	public class AdministracionController : Controller
	{
		public MyContext ctx = new MyContext();

		[MyAuthorizeAdmin]
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

		[MyAuthorizeAdmin]
		public ActionResult GestionInspector()
		{
			List<Inspector> inspectores = (from i in ctx.Inspectors
										   orderby i.id
										   select i).ToList();
			return View(inspectores);
		}

		[MyAuthorizeAdmin]
		public ActionResult CrearInspector()
		{
			return View();
		}

		[MyAuthorizeAdmin]
		[HttpPost]
		public ActionResult CrearInspector(Inspector inspector)
		{
			if (ModelState.IsValid)
			{
				ctx.Inspectors.Add(inspector);
				ctx.SaveChanges();

				if (inspector != null)
				{
					Session["Mensaje"] = "Inspector Creado";
					return RedirectToAction("GestionInspector");
				}

				else
				{
					ViewBag.Mensaje = "El Inspector no pudo ser creado";
					return View();
				}

			}

			else
			{
				ViewBag.Mensaje = "El Inspector no pudo ser creado";
				return View();
			}
		}

		[MyAuthorizeAdmin]
		public ActionResult EditarInspector(int Id)
		{
			Inspector inspector = (from i in ctx.Inspectors where i.id == Id select i).FirstOrDefault();

			return View(inspector);
		}

		[MyAuthorizeAdmin]
		[HttpPost]
		public ActionResult EditarInspector(Inspector imodificado)
		{
			if (ModelState.IsValid)
			{
				var inspector = (from i in ctx.Inspectors where i.id == imodificado.id select i).FirstOrDefault();
				inspector.nombre = imodificado.nombre;
				inspector.dni = imodificado.dni;
				inspector.legajo = imodificado.legajo;

				ctx.SaveChanges();
				Session["Mensaje"] = "El inspector " + inspector.nombre + " ha sido modificado exitosamente";
				return RedirectToAction("GestionInspector");
			}

			else
			{
				ViewBag.Mensaje = "El inspector no pudo ser editado";
				return View();
			}
		}

		[MyAuthorizeAdmin]
		public ActionResult EliminarInspector(int Id)
		{
			var inspector = (from i in ctx.Inspectors where i.id.Equals(Id) select i).FirstOrDefault();

			ctx.Inspectors.Remove(inspector);
			ctx.SaveChanges();

			Session["Mensaje"] = "Inspector Eliminado";
			return RedirectToAction("GestionInspector");
		}

		[MyAuthorizeAdmin]
		public ActionResult GestionConductor()
		{
			List<Conductor> conductor = (from i in ctx.Conductors
										 orderby i.id
										 select i).ToList();
			return View(conductor);
		}

		[MyAuthorizeAdmin]
		public ActionResult CrearConductor()
		{
			return View();
		}


		[MyAuthorizeAdmin]
		[HttpPost]
		public ActionResult CrearConductor(Conductor conductor)
		{
			if (ModelState.IsValid)
			{
				ctx.Conductors.Add(conductor);
				ctx.SaveChanges();

				if (conductor != null)
				{
					Session["Mensaje"] = "Conductor Creado";
					return RedirectToAction("GestionConductor");
				}

				else
				{
					ViewBag.Mensaje = "El Conductor no pudo ser creado";
					return View();
				}

			}

			else
			{
				ViewBag.Mensaje = "El Conductor no pudo ser creado";
				return View();
			}

		}


		[MyAuthorizeAdmin]
		public ActionResult EditarConductor(int id)
		{
			Conductor conductor = (from i in ctx.Conductors where i.id == id select i).FirstOrDefault();

			return View(conductor);
		}

		[MyAuthorizeAdmin]
		[HttpPost]

		public ActionResult EditarConductor(Conductor Editconductor)
		{
			if (ModelState.IsValid)
			{
				var conductor = (from i in ctx.Conductors where i.id == Editconductor.id select i).FirstOrDefault();
				conductor.Nombre = Editconductor.Nombre;
				conductor.Dni = Editconductor.Dni;
				conductor.Legajo = Editconductor.Legajo;

				ctx.SaveChanges();
				Session["Mensaje"] = "El Conductor " + conductor.Nombre + " ha sido modificado exitosamente";
				return RedirectToAction("GestionConductor");
			}

			else
			{
				ViewBag.Mensaje = "El Conductor no pudo ser editado";
				return View();
			}
		}


		[MyAuthorizeAdmin]
		public ActionResult EliminarConductor(int Id)
		{
			var conductor = (from i in ctx.Conductors where i.id.Equals(Id) select i).FirstOrDefault();

			ctx.Conductors.Remove(conductor);
			ctx.SaveChanges();

			Session["Mensaje"] = "Conductor Eliminado";
			return RedirectToAction("GestionConductor");
		}


		[MyAuthorizeAdmin]
		public ActionResult GestionParada()
		{
			List<Parada> parada = (from i in ctx.Paradas
								   orderby i.id
								   select i).ToList();
			return View(parada);
		}

		[MyAuthorizeAdmin]
		public ActionResult CrearParada()
		{
			return View();
		}

		[MyAuthorizeAdmin]
		[HttpPost]
		public ActionResult CrearParada(Parada parada)
		{
			if (ModelState.IsValid)
			{
				ctx.Paradas.Add(parada);
				ctx.SaveChanges();

				if (parada != null)
				{
					Session["Mensaje"] = "Parada Creada";
					return RedirectToAction("GestionParada");
				}

				else
				{
					ViewBag.Mensaje = "La parada no pudo ser creada";
					return View();
				}

			}

			else
			{
				ViewBag.Mensaje = "La parada no pudo ser creada";
				return View();
			}
		}


		[MyAuthorizeAdmin]
		public ActionResult EditarParada(int Id)
		{
			Parada parada = (from i in ctx.Paradas where i.id == Id select i).FirstOrDefault();

			return View(parada);
		}

		[MyAuthorizeAdmin]
		[HttpPost]
		public ActionResult EditarParada(Parada imodificado)
		{
			if (ModelState.IsValid)
			{
				var parada = (from i in ctx.Paradas where i.id == imodificado.id select i).FirstOrDefault();
				parada.nombre = imodificado.nombre;
				parada.direccion = imodificado.direccion;
				parada.nota = imodificado.nota;

				ctx.SaveChanges();
				Session["Mensaje"] = "La parada " + parada.nombre + " ha sido modificado exitosamente";
				return RedirectToAction("GestionParada");
			}

			else
			{
				ViewBag.Mensaje = "La Parada no pudo ser editado";
				return View();
			}
		}


		[MyAuthorizeAdmin]
		public ActionResult EliminarParada(int Id)
		{
			var parada = (from i in ctx.Paradas where i.id.Equals(Id) select i).FirstOrDefault();

			ctx.Paradas.Remove(parada);
			ctx.SaveChanges();

			Session["Mensaje"] = "Parada Eliminada";
			return RedirectToAction("GestionParada");
		}


		[MyAuthorizeAdmin]
		public ActionResult GestionSeccion()
		{
			List<Seccion> seccion = (from i in ctx.Seccions
									 orderby i.id
									 select i).ToList();
			return View(seccion);
		}


		[MyAuthorizeAdmin]
		public ActionResult CrearSeccion()
		{
			return View();
		}

		[MyAuthorizeAdmin]
		[HttpPost]
		public ActionResult CrearSeccion(Seccion seccion)
		{
			if (ModelState.IsValid)
			{
				ctx.Seccions.Add(seccion);
				ctx.SaveChanges();

				if (seccion != null)
				{
					Session["Mensaje"] = "Seccion Creada";
					return RedirectToAction("GestionSeccion");
				}

				else
				{
					ViewBag.Mensaje = "La Seccion no pudo ser creada";
					return View();
				}

			}

			else
			{
				ViewBag.Mensaje = "La Seccion no pudo ser creada";
				return View();
			}
		}


		[MyAuthorizeAdmin]
		public ActionResult EditarSeccion(int Id)
		{
			Seccion seccion = (from i in ctx.Seccions where i.id == Id select i).FirstOrDefault();

			return View(seccion);
		}

		[MyAuthorizeAdmin]
		[HttpPost]
		public ActionResult EditarSeccion(Seccion imodificado)
		{
			if (ModelState.IsValid)
			{
				var parada = (from i in ctx.Seccions where i.id == imodificado.id select i).FirstOrDefault();
				parada.nombre = imodificado.nombre;
				parada.direccion = imodificado.direccion;
				parada.nota = imodificado.nota;

				ctx.SaveChanges();
				Session["Mensaje"] = "La Seccion " + parada.nombre + " ha sido modificado exitosamente";
				return RedirectToAction("GestionSeccion");
			}

			else
			{
				ViewBag.Mensaje = "La Seccion no pudo ser editado";
				return View();
			}
		}

		[MyAuthorizeAdmin]
		public ActionResult EliminarSeccion(int Id)
		{
			var seccion = (from i in ctx.Seccions where i.id.Equals(Id) select i).FirstOrDefault();

			ctx.Seccions.Remove(seccion);
			ctx.SaveChanges();

			Session["Mensaje"] = "Seccion Eliminada";
			return RedirectToAction("GestionSeccion");
		}


		[MyAuthorizeAdmin]

		public ActionResult GestionReportes()
		{

			if (Session["IdUsuario"] == null)
			{
				TempData["urlController"] = Request.RequestContext.RouteData.Values["controller"].ToString();
				TempData["urlAction"] = Request.RequestContext.RouteData.Values["action"].ToString();
				return RedirectToAction("Login", "Home");
			}
			var inspec = ctx.Inspectors.ToList();
			ViewBag.Inspector = inspec;

			return View();


		}



		[HttpPost]
		public ActionResult ReportesInspeccion(InfoReportes r)
		{
			// Verifico que el lapso de tiempo no supere los 30 dias
			if (!(LapsoValido(r.FechaInicio, r.FechaFin)))
			{
				TempData["Error"] = "El lapso de per no debe ser mayor a 30 Dias.";
				return RedirectToAction("GestionReportes", "Administracion");
			}

			// Si el lapso de tiempo es valido, voy a la tabla de reserva y traigo todas las reservas comprendidas en ese lapso de tiempo
			// para esa pelicula
			List<Inspector> listaInspector = TraerInspectorPorPeriodo(r.FechaInicio, r.FechaFin, r.CodInspector);


			//Consulto si la lista llego vacia, en ese caso muetro un mensaje en pantalla
			if (listaInspector.Count() == 0)
			{
				TempData["Error"] = "No se encontraron Inspecciones para el Rango de Fecha solicitado";
				return RedirectToAction("GestionReportes", "Administracion");
			}

			//Creo una lista con los datos requeridos
			List<InfoBusquedaResultdo> listaBusquedaResultado = new List<InfoBusquedaResultdo>();

			foreach (Inspector inspeccion in listaInspector)
			{
				InfoBusquedaResultdo infoBusquedaResult = new InfoBusquedaResultdo();
				infoBusquedaResult.NombreChofer = TraerConductor(inspeccion.id).Nombre;
				infoBusquedaResult.Legajo = TraerConductor(inspeccion.id).Legajo.ToString();
				infoBusquedaResult.Dni = TraerConductor(inspeccion.id).Dni.ToString();
				infoBusquedaResult.NombreParada = TraerParada(inspeccion.id).nombre;
				listaBusquedaResultado.Add(infoBusquedaResult);
			}


			// LOGICA DE EXPORTACION 
			// SE DEBERIA HACER UN METODO APARTE Y AGARRAR LA LISTA DEL METODO BUSCAR Y PASARSELA AL DATASOURCE

			//var grid = new GridView();
			//grid.DataSource = listaBusquedaResultado;
			//grid.DataBind();
			//Response.ClearContent();
			//Response.AddHeader("content-disposition", "attachement; filename=data.xls");
			//Response.ContentType = "application/excel";
			//StringWriter sw = new StringWriter();
			//HtmlTextWriter htw = new HtmlTextWriter(sw);
			//grid.RenderControl(htw);
			//Response.Output.Write(sw.ToString());
			//Response.Flush();
			//Response.End();

			return View(listaBusquedaResultado);
		}








		private Conductor TraerConductor(int id)
		{
			var query = from c in ctx.Conductors where c.CodInspector == id select c;

			Conductor co = new Conductor();

			foreach (Conductor conductor in query)
			{
				co.id = conductor.id;
				co.Nombre = conductor.Nombre;
				co.Legajo = conductor.Legajo;
				co.Dni = conductor.Dni;
			}

			return co;
		}


		private Parada TraerParada(int id)
		{
			var query = from p in ctx.Paradas where p.id == id select p;

			Parada pa = new Parada();

			foreach (Parada parada in query)
			{
				pa.id = parada.id;
				pa.nombre = parada.nombre;

			}

			return pa;
		}


		private List<Inspector> TraerInspectorPorPeriodo(DateTime inicio, DateTime fin, int ins)
		{
			var Query = (from i in ctx.Inspectors where i.FechaCarga >= inicio && i.FechaCarga <= fin && i.id == i.id select i).ToList();
			return Query;
		}

		private bool LapsoValido(DateTime inicio, DateTime fin)
		{
			var dif = fin - inicio;
			int tiempo = dif.Days;

			if (tiempo <= 30) { return true; }

			return false;
		}


	}
}