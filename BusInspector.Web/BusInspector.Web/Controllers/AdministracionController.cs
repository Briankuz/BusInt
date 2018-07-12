using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
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

            PrepararReporte();
            return View();
            
		}

        public void PrepararReporte()
        {
            if (Session["IdUsuario"] == null)
            {
                TempData["urlController"] = Request.RequestContext.RouteData.Values["controller"].ToString();
                TempData["urlAction"] = Request.RequestContext.RouteData.Values["action"].ToString();
                 RedirectToAction("Login", "Home");
            }


            List<Inspector> inspec = ctx.Inspectors.OrderBy(m => m.nombre).ToList();
            Inspector i = new Inspector();
            i.id = 0;
            i.nombre = "Todos";
            inspec.Insert(0, i);
            ViewBag.Inspector = inspec;

            List<Conductor> conductores = ctx.Conductors.OrderBy(m => m.Nombre).ToList();
            Conductor c = new Conductor();
            c.id = 0;
            c.Nombre = "Todos";
            conductores.Insert(0, c);

            ViewBag.Inspector = inspec;
            ViewBag.Conductor = conductores;
        }




		[HttpPost]
		public ActionResult ReportesInspeccion(InfoReportes r)
		{
		
			List<vw_Inspeccion> listaInspector = TraerInspeccionesPorPeriodo(r.FechaInicio, r.FechaFin, r.CodInspector,r.CodConductor);
                      
            
            //Consulto si la lista llego vacia, en ese caso muetro un mensaje en pantalla
            if (listaInspector.Count() == 0)
			{
				TempData["Error"] = "No se encontraron Inspecciones para el Rango de Fecha solicitado";
				return RedirectToAction("GestionReportes", "Administracion");
			}

            return View(listaInspector);
		}


        [MyAuthorizeAdmin]
        public ActionResult GestionReportesObservacion()
        {
            PrepararReporte();

            return View();

        }

        [HttpPost]
        public ActionResult ReportesObservacion(InfoReportes r)
        {

            List<vw_Observacion> listaInspector = TraerObservacionesPorPeriodo(r.FechaInicio, r.FechaFin, r.CodInspector,r.CodConductor);


            //Consulto si la lista llego vacia, en ese caso muetro un mensaje en pantalla
            if (listaInspector.Count() == 0)
            {
                TempData["Error"] = "No se encontraron Observaciones para el Rango de Fecha solicitado";
                return RedirectToAction("GestionReportes", "Administracion");
            }

            return View(listaInspector);
        }

        [MyAuthorizeAdmin]
        public ActionResult GestionReportesControlInspecciones()
        {
            PrepararReporte();

            return View();

        }

        [HttpPost]
        public ActionResult ReportesControlInspecciones(InfoReportes r)
        {

            List<vw_Control_Inspecciones> listaInspector = TraerControlInspeccionesPeriodo(r.FechaInicio, r.FechaFin, r.CodInspector,r.CodConductor);


            //Consulto si la lista llego vacia, en ese caso muetro un mensaje en pantalla
            if (listaInspector.Count() == 0)
            {
                TempData["Error"] = "No se encontraron Inspecciones para el Rango de Fecha solicitado";
                return RedirectToAction("GestionReportesControlInspecciones", "Administracion");
            }

            return View(listaInspector);
        }

        [MyAuthorizeAdmin]
        public void ExportToExcel()
        {           
            var grid = new GridView();
            grid.DataSource = TempData["FullModel"];//model;
            grid.DataBind();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachement; filename=data.xls");
            Response.ContentType = "application/excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            grid.RenderControl(htw);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
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


		private List<vw_Inspeccion> TraerInspeccionesPorPeriodo(DateTime inicio, DateTime fin, int inspector,int conductor)
		{
            List<vw_Inspeccion> inspecciones = new List<vw_Inspeccion>();
            inicio = inicio.AddDays(-1);
            fin = fin.AddDays(1);
            
            inspecciones = ctx.vw_Inspeccion.OrderByDescending(m=> m.Fecha).Where(m => m.Fecha > inicio && m.Fecha < fin && (m.Inspector_id==inspector || inspector==0) && (m.Conductor_id == conductor || conductor== 0)).ToList();
            
			return inspecciones;
		}
        private List<vw_Observacion> TraerObservacionesPorPeriodo(DateTime inicio, DateTime fin, int inspector,int conductor)
        {
            List<vw_Observacion> obs = new List<vw_Observacion>();
            inicio = inicio.AddDays(-1);
            fin = fin.AddDays(1);

            
            obs = ctx.vw_Observacion.OrderByDescending(m => m.fecha).Where(m => m.fecha > inicio && m.fecha < fin && (m.Inspector_id == inspector || inspector == 0) && (m.Conductor_id == conductor || conductor == 0)).ToList();


            return obs;
        }
        private List<vw_Control_Inspecciones> TraerControlInspeccionesPeriodo(DateTime inicio, DateTime fin, int inspector, int conductor)
        {
            List<vw_Control_Inspecciones> ins = new List<vw_Control_Inspecciones>();
            inicio = inicio.AddDays(-1);
            fin = fin.AddDays(1);
            
            ins = ctx.vw_Control_Inspecciones.OrderByDescending(m => m.Fecha).Where(m => m.Fecha > inicio && m.Fecha < fin && (m.Inspector_id == inspector || inspector == 0) && (m.Conductor_Id == conductor || conductor == 0)).ToList();

            return ins;
        }

        private bool LapsoValido(DateTime inicio, DateTime fin)
		{
			var dif = fin - inicio;
			int tiempo = dif.Days;

			if (tiempo <= 30) { return true; }

			return false;
		}

        #region Interno

        [MyAuthorizeAdmin]
        public ActionResult GestionInterno()
        {
            List<Interno> interno = (from i in ctx.Internoes
                                     orderby i.id
                                     select i).ToList();


            return View(interno);
        }

        [MyAuthorizeAdmin]
        public ActionResult CrearInterno()
        {
            return View();
        }


        [MyAuthorizeAdmin]
        [HttpPost]
        public ActionResult CrearInterno(Interno interno)
        {
            if (ModelState.IsValid)
            {
                ctx.Internoes.Add(interno);
                ctx.SaveChanges();

                if (interno != null)
                {
                    Session["Mensaje"] = "Interno Creado";
                    return RedirectToAction("GestionInterno");
                }

                else
                {
                    ViewBag.Mensaje = "El interno no pudo ser creada";
                    return View();
                }

            }

            else
            {
                ViewBag.Mensaje = "El Interno no pudo ser creado";
                return View();
            }
        }


        [MyAuthorizeAdmin]
        public ActionResult EditarInterno(int Id)
        {
            Interno interno = (from i in ctx.Internoes where i.id == Id select i).FirstOrDefault();

            return View(interno);
        }


        [MyAuthorizeAdmin]
        [HttpPost]
        public ActionResult EditarInterno(Interno imodificado)
        {
            if (ModelState.IsValid)
            {
                var interno = (from i in ctx.Internoes where i.id == imodificado.id select i).FirstOrDefault();

                interno.Marca = imodificado.Marca;
                interno.Modelo = imodificado.Modelo;
                interno.Patente = imodificado.Patente;

                ctx.SaveChanges();

                Session["Mensaje"] = "El Interno " + interno.id + " ha sido modificado exitosamente";
                return RedirectToAction("GestionInterno");
            }

            else
            {
                ViewBag.Mensaje = "El interno no pudo ser editado";
                return View();
            }
        }

        [MyAuthorizeAdmin]
        public ActionResult EliminarInterno(int Id)
        {
            var interno = (from i in ctx.Internoes where i.id.Equals(Id) select i).FirstOrDefault();

            ctx.Internoes.Remove(interno);
            ctx.SaveChanges();

            Session["Mensaje"] = "Interno Eliminada";
            return RedirectToAction("GestionInterno");
        }

        [MyAuthorizeAdmin]
        public ActionResult GestionInternoConductor()
        {


            List<Conductor> condu = ListaConductores();


            // Creo una lista con los datos requeridos
            List<InfoConductorInterno> listaconductorinterno = new List<InfoConductorInterno>();

            foreach (Conductor conductor in condu)
            {
                InfoConductorInterno infoconductorinterno = new InfoConductorInterno();
                infoconductorinterno.Nombre = ObtenerConductor(Convert.ToInt32((conductor.id))).Nombre;
                infoconductorinterno.Dni = ObtenerConductor(Convert.ToInt32((conductor.id))).Dni;
                infoconductorinterno.Fecha = TraerFechaInterno(Convert.ToInt32((conductor.id))).Fecha;
                var interno = TraerFechaInterno(Convert.ToInt32(conductor.id)).Interno;
                infoconductorinterno.Interno = Convert.ToInt32(interno);

                listaconductorinterno.Add(infoconductorinterno);
            }


            return View(listaconductorinterno);
        }

        private void GuardarInternoConductor(Interno_Conductor intcond)
        {
            ctx.Interno_Conductor.Add(intcond);
            ctx.SaveChanges();
        }

        public List<Conductor> ListaConductores()
        {
            var conductor = (from c in ctx.Conductors select c).ToList();

            return conductor;
        }


        public List<Interno_Conductor> ListaFechaInterno()
        {
            var conductorinterno = (from c in ctx.Interno_Conductor select c).ToList();

            return conductorinterno;
        }


        private Conductor ObtenerConductor(int id)
        {
            var query = from c in ctx.Conductors where c.id == id select c;

            Conductor co = new Conductor();

            foreach (Conductor conductor in query)
            {
                co.Nombre = conductor.Nombre;
                co.Dni = conductor.Dni;

            }

            return co;
        }

        private Interno_Conductor TraerFechaInterno(int id)
        {
            var query = from c in ctx.Interno_Conductor where c.Conductor == id select c;

            Interno_Conductor co = new Interno_Conductor();

            foreach (Interno_Conductor conductor in query)
            {
                co.Fecha = conductor.Fecha;
                co.Interno = conductor.Interno;

            }

            return co;
        }

        #endregion

    }


}
