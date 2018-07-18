using BusInspector.Dal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BusInspector.Web.Models
{
    public class UsuarioViewModel
    {
        public Usuario usuario { get; set; }
        public Conductor conductor { get; set; }
        public Inspector inspector{ get; set; }
        public List<conductorInspector> lconductorinspector { get; set; }
        public conductorInspector conductorinspector { get; set; }
    }
    public class conductorInspector
    {
        public string codigo { get; set; }
        public string descripcion { get; set; }
    }
}