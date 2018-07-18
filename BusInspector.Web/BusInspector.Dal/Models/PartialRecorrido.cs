using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusInspector.Dal.Models
{
    [MetadataType(typeof(MetadataRecorrido))]
    public partial class Recorrido
    {
        public string Descripcion { get; set; }
    }
}
