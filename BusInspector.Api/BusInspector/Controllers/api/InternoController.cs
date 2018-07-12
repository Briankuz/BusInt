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
    [Authorize]
    public class InternoController : ApiController
    {
        private BusInspectorEntities db = new BusInspectorEntities();

       
        
        [Route("api/Interno/existe")]
        [Authorize]
        [HttpGet]
        [ResponseType(typeof(RespuestaViewModel))]
        public async Task<RespuestaViewModel> InternoExiste(int interno)
        {
            try
            {
                
                Interno i = db.Internoes.Where(m => m.id == interno).FirstOrDefault();
                //return RespuestaViewModel.OK(i);
                if (i == null)
                {
                    return RespuestaViewModel.OK(0);
                }
                else
                {
                    return RespuestaViewModel.OK(1);
                }

            }
            catch (Exception ex)
            {

                return RespuestaViewModel.Error(ex);
            }

        }
    }
}
