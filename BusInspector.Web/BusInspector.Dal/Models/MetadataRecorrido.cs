using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusInspector.Dal.Models
{
    class MetadataRecorrido
    {
        [Required(ErrorMessage = "Este campo no puede quedar vacio")]
        [StringLength(50)]
        public string Descripcion { get; set; }
    }
}
