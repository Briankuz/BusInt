﻿using System;
using System.ComponentModel.DataAnnotations;


namespace BusInspector.Dal
{
	public class MetadataSeccion
	{
        [RegularExpression("^[a-zA-Z ]*$", ErrorMessage = "Solo se admiten letras")]
        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
		[StringLength(50)]
		public string nombre { get; set; }


		[Required(ErrorMessage = "Este campo no puede quedar vacio")]
		[StringLength(50)]
		public string direccion { get; set; }

		[Required(ErrorMessage = "Este campo no puede quedar vacio")]
		[StringLength(50)]
		public string nota { get; set; }
	}
}
