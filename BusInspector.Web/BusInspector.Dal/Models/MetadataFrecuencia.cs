using System;
using System.ComponentModel.DataAnnotations;

namespace BusInspector.Dal
{
	public class MetadataFrecuencia
	{
        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
		[StringLength(50)]
		public string Descripcion { get; set; }

        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        //[DataType(DataType.Date)]
        //[DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:t}")]
        public string HorarioInicial { get; set; }

	}
}
