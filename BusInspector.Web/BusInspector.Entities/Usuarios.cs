using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusInspector.Entities
{
	public partial class Usuarios
	{
		public int IdUsuario { get; set; }
		public string NombreUsuario { get; set; }
		public string Password { get; set; }
	}
}
