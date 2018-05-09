using BusInspector.Data;
using BusInspector.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;

namespace BusInspector.Controllers.api
{
    public class ObservacionController : ApiController
    {
        private BusInspectorEntities bd = new BusInspectorEntities();
        [Authorize]
        [ResponseType(typeof(RespuestaViewModel))]
        public async Task<RespuestaViewModel> observar(Observacion o)
        {
            try
            {
                o.fecha = DateTime.Now;
                bd.Observacions.Add(o);
                bd.SaveChanges();
                RespuestaViewModel r = new RespuestaViewModel();
                return RespuestaViewModel.OK();
            }
            catch (Exception ex)
            {
                return RespuestaViewModel.Error(ex);                
            }

            
        }
     }
}
