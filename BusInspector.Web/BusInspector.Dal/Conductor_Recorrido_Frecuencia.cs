//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BusInspector.Dal
{
    using System;
    using System.Collections.Generic;
    
    public partial class Conductor_Recorrido_Frecuencia
    {
        public decimal Conductor { get; set; }
        public int Recorrido { get; set; }
        public int Frecuencia { get; set; }
    
        public virtual Conductor Conductor1 { get; set; }
        public virtual Frecuencia Frecuencia1 { get; set; }
        public virtual Recorrido Recorrido1 { get; set; }
    }
}
