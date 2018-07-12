using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BusInspector.Web.Models
{
	 public class InfoConductorInterno
	{
		public int Interno { set; get; }
		public DateTime Fecha { set; get; }
		public string  Nombre { set; get; }
		public int ? Dni { set; get; }
		
	}
}