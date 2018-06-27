using BusInspector.Dal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BusInspector.Web.Models
{
		public class InfoReportes
		{
			public DateTime FechaInicio { get; set; }
			public DateTime FechaFin { get; set; }
			public int Inspeccion { get; set; }
		    public int CodInspector { get; set; }
		    public int CodParada { get; set; }
	}
}