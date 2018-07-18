using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusInspector.Dal
{
    class MetadataInterno
    {
        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [StringLength(50)]
        public string Modelo { get; set; }

        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [StringLength(50)]
        public string Marca { get; set; }

        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [StringLength(50)]
        public string Patente { get; set; }

        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [Range(1900, 2018, ErrorMessage = "Ingrese un año valido")]
        public Nullable<short> Año { get; set; }

        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [Range(1, 100, ErrorMessage = "Ingrese un valor valido")]
        public Nullable<int> CantidadPasajeros { get; set; }
    }
}
