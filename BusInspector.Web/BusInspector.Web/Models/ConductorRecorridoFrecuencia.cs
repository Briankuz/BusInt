using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BusInspector.Dal;

namespace BusInspector.Web.Models
{
    public class ConductorRecorridoFrecuencia
    {
        public string nombreConductor { set; get; }
        public decimal idConductor { set; get; }
        public string nombreRecorrido { set; get; }
        public int idRecorrido { set; get; }
        public string nombreFrecuencia { set; get; }
        public int idFrecuencia { set; get; }
    }
}