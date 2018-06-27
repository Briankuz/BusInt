using System;
using System.ComponentModel.DataAnnotations;


namespace BusInspector.Dal
{
	public class MetadataConductor
	{

		[Required(ErrorMessage = "Este campo no puede quedar vacio")]
		[StringLength(50)]
		public string Nombre { get; set; }

		[Required(ErrorMessage = "Este campo no puede quedar vacio")]
		[Range(10000000, 99999999, ErrorMessage = "No es correcto")]
		public Nullable<decimal> Dni { get; set; }

		[Required(ErrorMessage = "Este campo no puede quedar vacio")]
		[Range(1, 100, ErrorMessage = "El numero no es correcto")]
		public Nullable<decimal> Legajo { get; set; }
	}
}
