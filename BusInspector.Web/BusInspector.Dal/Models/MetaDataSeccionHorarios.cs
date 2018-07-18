using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace BusInspector.Dal
{
   public class MetaDataSeccionHorarios
    {
        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [StringLength(5)]
        public int Seccion { get; set; }
        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [StringLength(5)]
        public int Recorrido { get; set; }
        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [StringLength(5)]
        public int Frecuencia { get; set; }
        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [DisplayName("Formato Hora debe ser hh:mm")]
        [DataType(DataType.Date)]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:t}")]
        public DateTime Hora { get; set; }
    }
}
