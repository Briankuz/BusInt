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
    
    public partial class vw_Control_Inspecciones
    {
        public int id { get; set; }
        public Nullable<int> Inspector_id { get; set; }
        public string Inspector_Nombre { get; set; }
        public Nullable<decimal> Interno { get; set; }
        public decimal Conductor_Id { get; set; }
        public string Conductor_Nombre { get; set; }
        public Nullable<System.DateTime> Fecha { get; set; }
        public Nullable<int> Seccion_Id { get; set; }
        public string Seccion_Nombre { get; set; }
        public Nullable<System.TimeSpan> hora_Inspeccion { get; set; }
        public Nullable<System.TimeSpan> hora_Seccion { get; set; }
        public Nullable<int> DifMinutos { get; set; }
        public string Atrasado { get; set; }
        public string Adelanto { get; set; }
    }
}
