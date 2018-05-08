using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusInspector.Entities
{
	[MetadataType(typeof(LoginMetadata))]
	public partial class Usuarios
	{
		public class LoginMetadata
		{
			[Required(ErrorMessage = "El usuario es invalido")]
			[StringLength(10, MinimumLength = 5)]
			public string NombreUsuario { get; set; }
		}

	}
}
