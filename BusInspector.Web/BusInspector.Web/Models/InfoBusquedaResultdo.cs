using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BusInspector.Web.Models
{
	public class InfoBusquedaResultdo
	{
		public string NombreChofer { set; get; }
		public string Dni { set; get; }
		public string Legajo { set; get; }
		public string NombreParada { set; get; }
		public int IdConductor { set; get; }
	}
}