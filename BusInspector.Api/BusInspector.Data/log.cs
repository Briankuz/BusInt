//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BusInspector.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class log
    {
        public int id { get; set; }
        public Nullable<System.DateTime> fecha { get; set; }
        public Nullable<int> tipo { get; set; }
        public string descripcion { get; set; }
    
        public virtual logs_tipo logs_tipo { get; set; }
    }
}
