using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BusInspector.Dal;
namespace BusInspector.Web.Models
{
    public class InformesFiltros
    {
        public  List<Conductor> Conductores { set; get; }
        public  List<Inspector> Inspectores { set; get; }
    }
}