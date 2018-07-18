using System;
using System.ComponentModel.DataAnnotations;

namespace BusInspector.Dal
{
    public class MetadataInspector
    {
        [RegularExpression("^[a-zA-Z ]*$", ErrorMessage = "Solo se admiten letras")]
        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [StringLength(50)]
        public string nombre { get; set; }

        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [Range(10000000, 99999999, ErrorMessage = "No es correcto")]
        public Nullable<decimal> dni { get; set; }

        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [RegularExpression("([1-9][0-9]*)", ErrorMessage = "Solo se admiten numeros")]
        public Nullable<decimal> legajo { get; set; }
    }
}