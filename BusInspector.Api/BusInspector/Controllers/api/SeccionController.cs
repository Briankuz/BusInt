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
    public class SeccionController : ApiController
    {
        private BusInspectorEntities db = new BusInspectorEntities();

        [Authorize]
        [ResponseType(typeof(RespuestaViewModel))]
        public async Task<RespuestaViewModel> GetSecciones()
        {
            try
            {

                //Where(m=> m.fechaBaja is null)
                return RespuestaViewModel.OK(db.Seccions.Where(m=> m.Latitud!=0).ToList());
            }
            catch (Exception ex)
            {
                return RespuestaViewModel.Error(ex);
            }

        }
        [Route("api/Seccion/me")]
        [Authorize]
        [ResponseType(typeof(RespuestaViewModel))]
        public async Task<RespuestaViewModel> Getseccion(int seccion)
        {
            try
            {
                Seccion s = db.Seccions.Where(m => m.id == seccion).FirstOrDefault();
                
                return RespuestaViewModel.OK(s);
            }
            catch (Exception ex)
            {

                return RespuestaViewModel.Error(ex);
            }

        }
      

    }
}
