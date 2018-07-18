using System;
using System.ComponentModel.DataAnnotations;


namespace BusInspector.Dal
{
	public class MetadataConductor
	{
        [RegularExpression("^[a-zA-Z ]*$", ErrorMessage ="Solo se admiten letras")]
        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
		[StringLength(50)]
		public string Nombre { get; set; }

		[Required(ErrorMessage = "Este campo no puede quedar vacio")]
		[Range(10000000, 99999999, ErrorMessage = "No es correcto")]
		public Nullable<decimal> Dni { get; set; }

		[Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [RegularExpression("([1-9][0-9]*)", ErrorMessage = "Solo se admiten numeros")]
        public Nullable<decimal> Legajo { get; set; }

    }
}
