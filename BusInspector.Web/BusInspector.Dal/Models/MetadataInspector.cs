using System;
using System.ComponentModel.DataAnnotations;

namespace BusInspector.Dal
{
    public class MetadataInspector
    {
        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [StringLength(50)]
        public string nombre { get; set; }

        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [Range(10000000, 99999999, ErrorMessage = "No es correcto")]
        public Nullable<decimal> dni { get; set; }

        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [Range(1, 100, ErrorMessage = "El numero no es correcto")]
        public Nullable<decimal> legajo { get; set; }
    }
}