using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace BusInspector.Models
{
    [Authorize]
    public class RespuestaViewModel
    {


        public string estado { get; set; }
        public List<respueta_errores> errores { get; set; }
        public object respuesta { get; set; }

        public static RespuestaViewModel OK()
        {
            return new RespuestaViewModel { estado = "ok", errores = new List<respueta_errores>() };
        }

        public static RespuestaViewModel OK(object obj)
        {
            return new RespuestaViewModel { estado = "ok", errores = new List<respueta_errores>(), respuesta = obj };
        }

        public static RespuestaViewModel Error(Exception ex)
        {
            var rs = new RespuestaViewModel { estado = "error", errores = new List<respueta_errores>() };
            rs.errores.Add(respueta_errores.newException(ex));
            return rs;
        }
        
    }
    public class respueta_errores
    {
        public int id { get; set; }
        public string descripcion { get; set; }
        public static respueta_errores newException(Exception ex)
        {
            return new respueta_errores { id = 401, descripcion = ex.Message };
        }
    }
}