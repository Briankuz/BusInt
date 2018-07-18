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
            DateTime hoy = DateTime.Today;
            DateTime manana = DateTime.Today.AddDays(1).AddTicks(-1);
            int internos = (from i in ctx.Internoes select i).Count();
            int inspeccionados = (from ins in ctx.Inspeccions where ins.Fecha >= hoy && ins.Fecha <= manana select ins).Distinct().Count();


            ViewBag.Internos = internos - inspeccionados;
            ViewBag.Inspeccionados = inspeccionados;

            ViewBag.Adelantados = (from ad in ctx.vw_Control_Inspecciones where ad.Adelanto == "si" && ad.Fecha >= hoy && ad.Fecha <= manana select ad).Count();
            ViewBag.Atrasados = (from at in ctx.vw_Control_Inspecciones where at.Atrasado == "si" && at.Fecha >= hoy && at.Fecha <= manana select at).Count();
            ViewBag.Atiempo = (from ti in ctx.vw_Control_Inspecciones where ti.Atrasado == "no" && ti.Adelanto == "no" && ti.Fecha >= hoy && ti.Fecha <= manana select ti).Count();

            List<Seccion> ListaSecciones = (from sec in ctx.Seccions
                                            select sec).ToList();
            List<int> Data = new List<int>();

            int Anio = DateTime.Now.Year;

            foreach (Seccion item in ListaSecciones)
            {
                int actual = (from ac in ctx.vw_Control_Inspecciones where ac.Seccion_Nombre == item.nombre && ac.Atrasado == "si" && ac.Fecha.Value.Year == Anio select ac).Count();
                Data.Add(actual);
            }

            ViewBag.Secciones = ListaSecciones;
            ViewBag.Data = Data;

            
            switch (Session["Rol"])
            {
     
                case "I":

                    return RedirectToAction("ReportesInspeccionUltimos", "Administracion");
                //break;
                case "C":

                    
                    return RedirectToAction("ReportesInspeccionUltimos", "Administracion");
                    //break;
            }

            return View();
        }

        [MyAuthorizeAdmin]
		public ActionResult GestionInspector()
		{
			List<Inspector> inspectores = (from i in ctx.Inspectors
										   orderby i.id
										   select i).ToList();
			Session["Mensaje"] = "";
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
            inspector.FechaCarga = DateTime.Now;
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
                if (inspector.FechaBaja != null)
                {
                    inspector.FechaBaja = imodificado.FechaBaja;
                }

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
			inspector.FechaBaja = DateTime.Today;
			
			ctx.SaveChanges();

			Session["Mensaje"] = "Inspector dado de baja correctamente";
			return RedirectToAction("GestionInspector");
		}

        [MyAuthorizeAdmin]
        public ActionResult AltaInspector(int Id)
        {
            var inspector = (from i in ctx.Inspectors where i.id.Equals(Id) select i).FirstOrDefault();
            inspector.FechaBaja = null;

            ctx.SaveChanges();

            Session["Mensaje"] = "Inspector dado de alta correctamente";
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
					Session["Mensaje"] = "Conductor Creado correctamente";
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
                if (conductor.Baja != null) {
                    conductor.Baja = Editconductor.Baja;
                }

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
            conductor.Baja = DateTime.Today;

			ctx.SaveChanges();

			Session["Mensaje"] = "Conductor dado de baja correctamente";
			return RedirectToAction("GestionConductor");
		}

        [MyAuthorizeAdmin]
        public ActionResult AltaConductor(int Id)
        {
            var conductor = (from i in ctx.Conductors where i.id.Equals(Id) select i).FirstOrDefault();
            conductor.Baja = null;

            ctx.SaveChanges();

            Session["Mensaje"] = "Conductor dado de alta correctamente";
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
					Session["Mensaje"] = "Parada creada";
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
       
        public ActionResult ReportesInspeccionUltimos()
        {

            AdministracionController c = new AdministracionController();
            InfoReportes r = new InfoReportes();
            r.FechaFin = DateTime.Now;
            r.FechaInicio = DateTime.Now.AddDays(-10);
            switch (Session["Rol"])
            {

                case "I":
                    r.CodConductor = 0;
                    r.CodInspector = int.Parse(Session["RolId"].ToString());
                    break;
                case "C":
                    r.CodConductor = int.Parse(Session["RolId"].ToString());
                    r.CodInspector = 0;
                    break;
            }                    
                    
                    List<vw_Inspeccion> listaInspector = TraerInspeccionesPorPeriodo(r.FechaInicio, r.FechaFin, r.CodInspector, r.CodConductor);


            //Consulto si la lista llego vacia, en ese caso muetro un mensaje en pantalla
            if (listaInspector.Count() == 0)
            {
                TempData["Error"] = "No se encontraron Inspecciones para el Rango de Fecha solicitado";
                return RedirectToAction("GestionReportes", "Administracion");
            }

            return View(listaInspector);
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
                interno.Activo = "SI";
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
				interno.Año = imodificado.Año;
				interno.CantidadPasajeros = imodificado.CantidadPasajeros;
                interno.Activo = imodificado.Activo;

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
            interno.Activo = "NO";

            ctx.SaveChanges();

            Session["Mensaje"] = "Interno dado de baja";
            return RedirectToAction("GestionInterno");
        }

        [MyAuthorizeAdmin]
        public ActionResult GestionInternoConductor()
        {

            List<Interno_Conductor> internoCond = (from i in ctx.Interno_Conductor
                                                   orderby i.Interno
                                                   select i).ToList();

			Session["Mensaje"] = "";

			
			return View(internoCond);


            //CODIDO DONDE CREO UNA CLASE NUEVA PARA INCORPORAR LOS CAMPOS QUE NECESITO DE DIFERENTES TABLAS EN MI GRILLA
            //List<Conductor> condu = ListaConductores(); 


            //// Creo una lista con los datos requeridos
            //List<InfoConductorInterno> listaconductorinterno = new List<InfoConductorInterno>();

            //foreach (Conductor conductor in condu)
            //{
            //	InfoConductorInterno infoconductorinterno = new InfoConductorInterno();
            //	infoconductorinterno.Nombre = ObtenerConductor(Convert.ToInt32((conductor.id))).Nombre;
            //	infoconductorinterno.Dni = ObtenerConductor(Convert.ToInt32((conductor.id))).Dni;
            //	infoconductorinterno.Fecha = TraerFechaInterno(Convert.ToInt32((conductor.id))).Fecha;
            //	var interno = TraerFechaInterno(Convert.ToInt32(conductor.id)).Interno;
            //	infoconductorinterno.Interno = Convert.ToInt32(interno);

            //	listaconductorinterno.Add(infoconductorinterno);
            //}


            //return View(listaconductorinterno);
        }

        [MyAuthorizeAdmin]
        public ActionResult CrearInternoConductor()
        {
            ViewBag.ListaInternos = (from i in ctx.Internoes select i).ToList();
            ViewBag.ListaConductores = (from c in ctx.Conductors select c).ToList();

            return View();
        }

        [MyAuthorizeAdmin]
        [HttpPost]
        public ActionResult CrearInternoConductor(Interno_Conductor internoCond)
        {
            ViewBag.ListaInternos = (from i in ctx.Internoes where i.Activo == "SI" select i).ToList();
            ViewBag.ListaConductores = (from c in ctx.Conductors where c.Baja == null select c).ToList();
            var ok = (from ic
                      in ctx.Interno_Conductor
                      where ic.Interno == internoCond.Interno && ic.Conductor == internoCond.Conductor && ic.Fecha == internoCond.Fecha
                      select ic).FirstOrDefault();

            if (ModelState.IsValid && ok == null)
            {
                ctx.Interno_Conductor.Add(internoCond);
                ctx.SaveChanges();

                if (internoCond != null)
                {
                    Session["Mensaje"] = "Interno Conductor Creado";
                    return RedirectToAction("GestionInternoConductor");
                }

                else
                {
                    ViewBag.Mensaje = "Interno Conductor no pudo ser Creado o ya existe";
                    return View();
                }

            }

            else
            {
                ViewBag.Mensaje = "Interno Conductor no pudo ser Creado o ya existe";
                return View();
            }
        }

        //[MyAuthorizeAdmin]
        //public ActionResult EditarInternoConductor(int Id)
        //{
        //    ViewBag.ListaInternos = (from i in ctx.Internoes select i).ToList();
        //    ViewBag.ListaConductores = (from c in ctx.Conductors select c).ToList();
        //    Interno_Conductor internocond = (from i in ctx.Interno_Conductor where i.Interno == Id select i).FirstOrDefault();

        //    return View(internocond);
        //}

        //[MyAuthorizeAdmin]
        //[HttpPost]
        //public ActionResult EditarInternoConductor(Interno_Conductor imodificado)
        //{
        //    ViewBag.ListaInternos = (from i in ctx.Internoes select i).ToList();
        //    ViewBag.ListaConductores = (from c in ctx.Conductors select c).ToList();
        //    var ok = (from ic
        //              in ctx.Interno_Conductor
        //              where ic.Interno == imodificado.Interno && ic.Conductor ==imodificado.Conductor && ic.Fecha == imodificado.Fecha
        //              select ic).FirstOrDefault();

        //    if (ModelState.IsValid && ok == null)
        //    {
        //        var intcond = (from i in ctx.Interno_Conductor where i.Interno == imodificado.Interno select i).FirstOrDefault();

        //        intcond.Fecha = imodificado.Fecha;

        //        ctx.SaveChanges();
        //        Session["Mensaje"] = "El Interno por Conductor ha sido Modificado exitosamente";
        //        return RedirectToAction("GestionInternoConductor");
        //    }

        //    else
        //    {
        //        ViewBag.Mensaje = "El interno por conductor no pudo ser editado";
        //        return View();
        //    }
        //}

        [MyAuthorizeAdmin]
        public ActionResult EliminarInternoConductor(int Id)
        {
            var intCond = (from i in ctx.Interno_Conductor where i.Interno.Equals(Id) select i).FirstOrDefault();

            ctx.Interno_Conductor.Remove(intCond);
            ctx.SaveChanges();

            Session["Mensaje"] = "Interno Conductor Eliminado";
            return RedirectToAction("GestionInternoConductor");
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

        #region Seccion_Horario-Recorrido-Frecuencia

        //[MyAuthorizeAdmin]
        //public ActionResult GestionSeccion()
        //{
        //    List<Seccion> seccion = (from i in ctx.Seccions
        //                             orderby i.id
        //                             select i).ToList();
        //    return View(seccion);
        //}

        [MyAuthorizeAdmin]
        public ActionResult GestionFrecuencia()
        {
            List<Frecuencia> frecuencia = (from i in ctx.Frecuencias
                                           orderby i.Id
                                           select i).ToList();
			Session["Mensaje"] = "";
			return View(frecuencia);
        }

        [MyAuthorizeAdmin]
        public ActionResult GestionRecorrido()
        {
            List<Recorrido> recorrido = (from i in ctx.Recorridoes
                                         orderby i.Id
                                         select i).ToList();
			
			return View(recorrido);
        }

        [MyAuthorizeAdmin]
        public ActionResult GestionSeccionHorarios()
        {
            List<Seccion_Horario> seccionHorario = (from i in ctx.Seccion_Horario
                                                    join i2 in ctx.Recorridoes on i.Recorrido equals i2.Id
                                                    join i3 in ctx.Seccions on i.Seccion equals i3.id
                                                    join i4 in ctx.Frecuencias on i.Frecuencia equals i4.Id
                                                    orderby i.Recorrido, i.Seccion, i.Frecuencia
                                                    select i).ToList();
			Session["Mensaje"] = "";
			return View(seccionHorario);

        }

        //[MyAuthorizeAdmin]
        //public ActionResult CrearSeccion()
        //{
        //    return View();
        //}

        [MyAuthorizeAdmin]
        public ActionResult CrearFrecuencia()
        {
            return View();
        }

        [MyAuthorizeAdmin]
        public ActionResult CrearRecorrido()
        {
            return View();
        }

        [MyAuthorizeAdmin]
        public ActionResult CrearSeccionHorario()
        {
            var seccion = (from i in ctx.Seccions
                           select i).ToList();

            ViewBag.Seccion = seccion;

            var recorrido = (from i in ctx.Recorridoes
                             select i).ToList();

            ViewBag.Recorrido = recorrido;

            var frecuencia = (from i in ctx.Frecuencias
                              select i).ToList();

            ViewBag.Frecuencia = frecuencia;

            return View();

        }

        //[MyAuthorizeAdmin]
        //[HttpPost]
        //public ActionResult CrearSeccion(Seccion seccion)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        ctx.Seccions.Add(seccion);
        //        ctx.SaveChanges();

        //        if (seccion != null)
        //        {
        //            Session["Mensaje"] = "Seccion Creada";
        //            return RedirectToAction("GestionSeccion");
        //        }

        //        else
        //        {
        //            ViewBag.Mensaje = "La Seccion no pudo ser creada";
        //            return View();
        //        }

        //    }

        //    else
        //    {
        //        ViewBag.Mensaje = "La Seccion no pudo ser creada";
        //        return View();
        //    }
        //}

        [MyAuthorizeAdmin]
        [HttpPost]
        public ActionResult CrearFrecuencia(Frecuencia frecuencia)
        {
            if (ModelState.IsValid)
            {
                ctx.Frecuencias.Add(frecuencia);
                ctx.SaveChanges();

                if (frecuencia != null)
                {
                    Session["Mensaje"] = "Frecuencia Creada";
                    return RedirectToAction("GestionFrecuencia");
                }

                else
                {
                    ViewBag.Mensaje = "La Frecuencia no pudo ser creada";
                    return View();
                }

            }

            else
            {
                ViewBag.Mensaje = "La Frecuencia no pudo ser creada";
                return View();
            }
        }

        [MyAuthorizeAdmin]
        [HttpPost]
        public ActionResult CrearRecorrido(Recorrido recorrido)
        {
            if (ModelState.IsValid)
            {
                ctx.Recorridoes.Add(recorrido);
                ctx.SaveChanges();

                if (recorrido != null)
                {
                    Session["Mensaje"] = "Recorrido Creado";
                    return RedirectToAction("GestionRecorrido");
                }

                else
                {
                    ViewBag.Mensaje = "El Recorrido no pudo ser creado";
                    return View();
                }

            }

            else
            {
                ViewBag.Mensaje = "El Recorrido no pudo ser creada";
                return View();
            }
        }

        [MyAuthorizeAdmin]
        [HttpPost]
        public ActionResult CrearSeccionHorario(Seccion_Horario seccionHorario)
        {
            if (ModelState.IsValid)
            {
                Seccion_Horario seccionHorarioChk = (from i in ctx.Seccion_Horario
                                                     where i.Recorrido == seccionHorario.Recorrido
                                                     && i.Seccion == seccionHorario.Seccion
                                                     && i.Frecuencia == seccionHorario.Frecuencia
                                                     select i).FirstOrDefault();

                if (seccionHorarioChk != null)
                {
                    Session["Mensaje"] = "El Horario ya existe.";
                    return RedirectToAction("GestionSeccionHorarios");
                }

                ctx.Seccion_Horario.Add(seccionHorario);
                ctx.SaveChanges();

                if (seccionHorario != null)
                {
                    Session["Mensaje"] = "Horario Creado";
                    return RedirectToAction("GestionSeccionHorarios");
                }

                else
                {
                    ViewBag.Mensaje = "El Horario no pudo ser creado";
                    return View();
                }

            }

            else
            {
                ViewBag.Mensaje = "El Horario no pudo ser creado";
                return View();
            }
        }

        //[MyAuthorizeAdmin]
        //public ActionResult EditarSeccion(int Id)
        //{
        //    Seccion seccion = (from i in ctx.Seccions where i.id == Id select i).FirstOrDefault();

        //    return View(seccion);
        //}

        [MyAuthorizeAdmin]
        public ActionResult EditarFrecuencia(int Id)
        {
            Frecuencia frecuencia = (from i in ctx.Frecuencias where i.Id == Id select i).FirstOrDefault();

            return View(frecuencia);
        }

        [MyAuthorizeAdmin]
        public ActionResult EditarRecorrido(int Id)
        {
            Recorrido recorrido = (from i in ctx.Recorridoes where i.Id == Id select i).FirstOrDefault();

            return View(recorrido);
        }

        [MyAuthorizeAdmin]
        public ActionResult EditarSeccionHorarios(int Recorrido, int Seccion, int Frecuencia)
        {
            Seccion_Horario seccionHorario = (from i in ctx.Seccion_Horario where i.Recorrido == Recorrido && i.Seccion == Seccion && i.Frecuencia == Frecuencia select i).FirstOrDefault();

            var seccion = (from i in ctx.Seccions
                           select i).ToList();

            ViewBag.Seccion = seccion;

            var recorrido = (from i in ctx.Recorridoes
                             select i).ToList();

            ViewBag.Recorrido = recorrido;

            var frecuencia = (from i in ctx.Frecuencias
                              select i).ToList();

            ViewBag.Frecuencia = frecuencia;


            return View(seccionHorario);
        }

        //[MyAuthorizeAdmin]
        //[HttpPost]
        //public ActionResult EditarSeccion(Seccion imodificado)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        var parada = (from i in ctx.Seccions where i.id == imodificado.id select i).FirstOrDefault();
        //        parada.nombre = imodificado.nombre;
        //        parada.direccion = imodificado.direccion;
        //        parada.nota = imodificado.nota;

        //        ctx.SaveChanges();
        //        Session["Mensaje"] = "La Seccion " + parada.nombre + " ha sido modificado exitosamente";
        //        return RedirectToAction("GestionSeccion");
        //    }

        //    else
        //    {
        //        ViewBag.Mensaje = "La Seccion no pudo ser editado";
        //        return View();
        //    }
        //}

        [MyAuthorizeAdmin]
        [HttpPost]
        public ActionResult EditarFrecuencia(Frecuencia imodificado)
        {
            if (ModelState.IsValid)
            {
                var frecuencia = (from i in ctx.Frecuencias where i.Id == imodificado.Id select i).FirstOrDefault();
                frecuencia.Descripcion = imodificado.Descripcion;
                frecuencia.HorarioInicial = imodificado.HorarioInicial;

                ctx.SaveChanges();
                Session["Mensaje"] = "La Frecuencia " + frecuencia.Descripcion + " ha sido modificada exitosamente";
                return RedirectToAction("GestionFrecuencia");
            }

            else
            {
                ViewBag.Mensaje = "La Frecuencia no pudo ser editada";
                return View();
            }
        }

        [MyAuthorizeAdmin]
        [HttpPost]
        public ActionResult EditarRecorrido(Recorrido imodificado)
        {
            if (ModelState.IsValid)
            {
                var recorrido = (from i in ctx.Recorridoes where i.Id == imodificado.Id select i).FirstOrDefault();
                recorrido.Descripcion = imodificado.Descripcion;

                ctx.SaveChanges();
                Session["Mensaje"] = "El Recorrido " + recorrido.Descripcion + " ha sido modificado exitosamente";
                return RedirectToAction("GestionRecorrido");
            }

            else
            {
                ViewBag.Mensaje = "El Recorrido no pudo ser editado";
                return View();
            }
        }

        [MyAuthorizeAdmin]
        [HttpPost]
        public ActionResult EditarSeccionHorarios(Seccion_Horario imodificado)
        {
            if (ModelState.IsValid)
            {
                var seccionHorario = (from i in ctx.Seccion_Horario
                                      where i.Recorrido == imodificado.Recorrido
                                      && i.Seccion == imodificado.Seccion
                                      && i.Frecuencia == imodificado.Frecuencia
                                      select i).FirstOrDefault();
                seccionHorario.Recorrido = imodificado.Recorrido;
                seccionHorario.Seccion = imodificado.Seccion;
                seccionHorario.Frecuencia = imodificado.Frecuencia;
                seccionHorario.Hora = imodificado.Hora;

                ctx.SaveChanges();
                Session["Mensaje"] = "El Horario ha sido modificado exitosamente";
                return RedirectToAction("GestionSeccionHorarios");
            }

            else
            {
                ViewBag.Mensaje = "El Horario no pudo ser editado";
                return View();
            }
        }

        //[MyAuthorizeAdmin]
        //public ActionResult EliminarSeccion(int Id)
        //{
        //    var seccion = (from i in ctx.Seccions where i.id.Equals(Id) select i).FirstOrDefault();

        //    ctx.Seccions.Remove(seccion);
        //    ctx.SaveChanges();

        //    Session["Mensaje"] = "Seccion Eliminada";
        //    return RedirectToAction("GestionSeccion");
        //}

        [MyAuthorizeAdmin]
        public ActionResult EliminarFrecuencia(int Id)
        {
            var frecuencia = (from i in ctx.Frecuencias where i.Id.Equals(Id) select i).FirstOrDefault();

            ctx.Frecuencias.Remove(frecuencia);
            ctx.SaveChanges();

            Session["Mensaje"] = "Frecuencia Eliminada";
            return RedirectToAction("GestionFrecuencia");
        }

        [MyAuthorizeAdmin]
        public ActionResult EliminarRecorrido(int Id)
        {
            var recorrido = (from i in ctx.Recorridoes where i.Id.Equals(Id) select i).FirstOrDefault();

            ctx.Recorridoes.Remove(recorrido);
            ctx.SaveChanges();

            Session["Mensaje"] = "Recorrido Eliminado";
            return RedirectToAction("GestionRecorrido");
        }

        [MyAuthorizeAdmin]
        public ActionResult EliminarSeccionHorario(int Recorrido, int Seccion, int Frecuencia)
        {
            var seccionHorario = (from i in ctx.Seccion_Horario
                                  where i.Recorrido.Equals(Recorrido)
                                  && i.Seccion.Equals(Seccion)
                                  && i.Frecuencia.Equals(Frecuencia)
                                  select i).FirstOrDefault();

            ctx.Seccion_Horario.Remove(seccionHorario);
            ctx.SaveChanges();

            Session["Mensaje"] = "Horario Eliminado";
            return RedirectToAction("GestionSeccionHorarios");
        }
        #endregion

        #region Conductor_recorrido_frecuencia

        [MyAuthorizeAdmin]
        public ActionResult GestionConductorRecorridoFrecuencia()
        {
            var conductorRecorridoFrecuencia = (from crf in ctx.Conductor_Recorrido_Frecuencia
                                                join conductor in ctx.Conductors on crf.Conductor equals conductor.id
                                                join recorrido in ctx.Recorridoes on crf.Recorrido equals recorrido.Id
                                                join frecuencia in ctx.Frecuencias on crf.Frecuencia equals frecuencia.Id
                                                orderby crf.Conductor
                                                select new ConductorRecorridoFrecuencia()
                                                {
                                                    nombreConductor = conductor.Nombre,
                                                    nombreRecorrido = recorrido.Descripcion,
                                                    nombreFrecuencia = frecuencia.Descripcion,
                                                    idConductor = conductor.id,
                                                    idFrecuencia = frecuencia.Id,
                                                    idRecorrido = recorrido.Id
                                                }).ToList();
			Session["Mensaje"] = "";
			return View(conductorRecorridoFrecuencia);
        }

        [MyAuthorizeAdmin]
        public ActionResult CrearConductorRecorridoFrecuencia()
        {
            ViewBag.ListaConductores = (from con in ctx.Conductors where con.Baja == null select con).ToList();
            ViewBag.ListaRecorridos = (from rec in ctx.Recorridoes select rec).ToList();
            ViewBag.ListaFrecuencias = (from fre in ctx.Frecuencias select fre).ToList();

            return View();
        }

        [MyAuthorizeAdmin]
        [HttpPost]
        public ActionResult CrearConductorRecorridoFrecuencia(Conductor_Recorrido_Frecuencia crf)
        {
            ViewBag.ListaConductores = (from con in ctx.Conductors where con.Baja == null select con).ToList();
            ViewBag.ListaRecorridos = (from rec in ctx.Recorridoes select rec).ToList();
            ViewBag.ListaFrecuencias = (from fre in ctx.Frecuencias select fre).ToList();

            if (ModelState.IsValid)
            {
                var ok = (from crf1
                          in ctx.Conductor_Recorrido_Frecuencia
                          where crf1.Conductor == crf.Conductor && crf1.Recorrido == crf.Recorrido && crf1.Frecuencia == crf.Frecuencia
                          select crf1).FirstOrDefault();

                if (crf != null && ok == null)
                {
                    ctx.Conductor_Recorrido_Frecuencia.Add(crf);
                    ctx.SaveChanges();

                    Session["Mensaje"] = "Conductor-Recorrido-Frecuencia Creado!";
                    return RedirectToAction("GestionConductorRecorridoFrecuencia");
                }

                else
                {
                    ViewBag.Mensaje = "El Conductor-Recorrido-Frecuencia no pudo ser creado o ya existe";
                    return View();
                }

            }

            else
            {
                ViewBag.Mensaje = "El Conductor-Recorrido-Frecuencia no pudo ser creado o ya existe";
                return View();
            }
        }

        [MyAuthorizeAdmin]
        public ActionResult EliminarConductorRecorridoFrecuencia(decimal idCond, int idRec, int idFrec)
        {
            var crf = (from crf1
                       in ctx.Conductor_Recorrido_Frecuencia
                       where crf1.Conductor.Equals(idCond) && crf1.Recorrido.Equals(idRec) && crf1.Frecuencia.Equals(idFrec)
                       select crf1).FirstOrDefault();

            ctx.Conductor_Recorrido_Frecuencia.Remove(crf);
            ctx.SaveChanges();

            Session["Mensaje"] = "Conductor-Recorrido-Frecuencia Eliminado";
            return RedirectToAction("GestionConductorRecorridoFrecuencia");
        }


        #endregion


        #region Usuario


        [MyAuthorizeAdmin]
        public ActionResult GestionUsuario()
        {
            List<Usuario> lusuario = (from i in ctx.Usuarios
                                      orderby i.NombreUsuario
                                      select i).ToList();
            List<UsuarioViewModel> uvw = new List<UsuarioViewModel>();
            UsuarioViewModel u = new UsuarioViewModel();


            foreach (var usuario in lusuario)
            {
                u = new UsuarioViewModel();
                u.usuario = usuario;


                switch (usuario.Rol)
                {
                    case "A":

                        break;
                    case "I":
                        u.inspector = ctx.Inspectors.Where(m => m.id == usuario.RolId).FirstOrDefault();
                        break;
                    case "C":
                        u.conductor = ctx.Conductors.Where(m => m.id == usuario.RolId).FirstOrDefault();
                        break;
                }
                uvw.Add(u);
            }



            return View(uvw);
        }

        [MyAuthorizeAdmin]
        public ActionResult CrearUsuario()
        {
            UsuarioViewModel u = new UsuarioViewModel();


            List<conductorInspector> cil = new List<conductorInspector>();
            conductorInspector ci = new conductorInspector();

            ci = new conductorInspector();
            ci.codigo = "";
            ci.descripcion = "Admin";
            cil.Add(ci);

            foreach (var item in ctx.Conductors)
            {
                ci = new conductorInspector();
                ci.codigo = "C-" + item.id.ToString();
                ci.descripcion = "C-" + item.Nombre;
                cil.Add(ci);
            }
            foreach (var item in ctx.Inspectors)
            {
                ci = new conductorInspector();
                ci.codigo = "I-" + item.id.ToString();
                ci.descripcion = "I-" + item.nombre;
                cil.Add(ci);
            }
            //u.lconductorinspector = cil;
            u.conductorinspector = new conductorInspector();
            u.usuario = new Usuario();
            ViewBag.conductorinspector = cil;
            return View(u);
        }

        [MyAuthorizeAdmin]
        [HttpPost]
        public ActionResult CrearUsuario(UsuarioViewModel uvw)
        {
            if (ModelState.IsValid)
            {
                if (uvw.conductorinspector.codigo != "")
                {
                    var result = uvw.conductorinspector.codigo.Split(new string[] { "-" }, StringSplitOptions.None);
                    uvw.usuario.Rol = result[0];
                    uvw.usuario.RolId = decimal.Parse(result[1]);

                }
                else
                { uvw.usuario.Rol = "A"; }


                ctx.Usuarios.Add(uvw.usuario);
                ctx.SaveChanges();

                if (uvw.usuario != null)
                {
                    Session["Mensaje"] = "Usuario Creada";
                    return RedirectToAction("GestionUsuario");
                }

                else
                {
                    ViewBag.Mensaje = "El usuario no pudo ser creado";
                    return View();
                }

            }

            else
            {
                ViewBag.Mensaje = "El usuario no pudo ser creado";
                return View();
            }
        }


        [MyAuthorizeAdmin]
        public ActionResult EditarUsuario(int Id)
        {
            Usuario usuario = (from i in ctx.Usuarios where i.IdUsuario == Id select i).FirstOrDefault();

            UsuarioViewModel u = new UsuarioViewModel();


            List<conductorInspector> cil = new List<conductorInspector>();
            conductorInspector ci = new conductorInspector();

            ci = new conductorInspector();
            ci.codigo = "";
            ci.descripcion = "Admin";
            cil.Add(ci);

            foreach (var item in ctx.Conductors)
            {
                ci = new conductorInspector();
                ci.codigo = "C-" + item.id.ToString();
                ci.descripcion = "C-" + item.Nombre;
                cil.Add(ci);
            }
            foreach (var item in ctx.Inspectors)
            {
                ci = new conductorInspector();
                ci.codigo = "I-" + item.id.ToString();
                ci.descripcion = "I-" + item.nombre;
                cil.Add(ci);
            }

            u.conductorinspector = new conductorInspector();
            if (usuario.Rol == "A")
            { u.conductorinspector.codigo = ""; }
            else
            { u.conductorinspector.codigo = usuario.Rol + "-" + usuario.RolId.ToString(); }
            u.usuario = usuario;
            ViewBag.conductorinspector = cil;
            return View(u);


        }

        [MyAuthorizeAdmin]
        [HttpPost]
        public ActionResult EditarUsuario(UsuarioViewModel imodificado)
        {
            if (ModelState.IsValid)
            {
                var usuario = (from i in ctx.Usuarios where i.IdUsuario == imodificado.usuario.IdUsuario select i).FirstOrDefault();
                usuario.NombreUsuario = imodificado.usuario.NombreUsuario;
                usuario.Password = imodificado.usuario.Password;

                if (imodificado.conductorinspector.codigo == "" || imodificado.conductorinspector.codigo == null)
                {
                    usuario.Rol = "A";
                }
                else
                {
                    var result = imodificado.conductorinspector.codigo.Split(new string[] { "-" }, StringSplitOptions.None);
                    usuario.Rol = result[0];
                    usuario.RolId = decimal.Parse(result[1]);

                }

                usuario.fechabaja = null;
                ctx.SaveChanges();
                Session["Mensaje"] = "El usuario " + usuario.NombreUsuario + " ha sido modificado exitosamente";
                return RedirectToAction("GestionUsuario");
            }

            else
            {
                ViewBag.Mensaje = "El usuario no pudo ser editado";
                return View();
            }
        }


        [MyAuthorizeAdmin]
        public ActionResult EliminarUsuario(int Id)
        {
            var usuario = (from i in ctx.Usuarios where i.IdUsuario.Equals(Id) select i).FirstOrDefault();

            usuario.fechabaja = DateTime.Now;
            ctx.SaveChanges();

            Session["Mensaje"] = "Usuario Eliminado";
            return RedirectToAction("GestionUsuario");
        }

        #endregion
    }


}
