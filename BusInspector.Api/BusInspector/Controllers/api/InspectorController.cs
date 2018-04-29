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
    public class InspectorController : ApiController
    {
        private BusInspectorEntities db = new BusInspectorEntities();

        [Authorize]
        [ResponseType(typeof(RespuestaViewModel))]
        public async Task<RespuestaViewModel> Firmar(Inspeccion inspeccion)
        {
            try
            {

                inspeccion.Fecha = DateTime.Now;
                if (!ModelState.IsValid)
                {
                    return RespuestaViewModel.Error(new Exception("Model invalido"));
                }

                db.Inspeccions.Add(inspeccion);
                await db.SaveChangesAsync();
                return RespuestaViewModel.OK();
            }
            catch (Exception ex)
            {
                return RespuestaViewModel.Error(ex);
            }

        }
        [Authorize]        
        [ResponseType(typeof(RespuestaViewModel))]
        public async Task<RespuestaViewModel> GetInspecciones(int inspector)
        {
            try
            {
                //falta filtro por dia actual
                var inspecciones = db.Inspeccions.OrderByDescending(m=>m.Fecha).Where(m => m.Inspector == inspector).Take(10).ToList();
                InspectorViewModel inspectorViewModel;
                List<InspectorViewModel> li = new List<InspectorViewModel>();
                foreach (var inspeccion in inspecciones)
                {
                    inspectorViewModel= new InspectorViewModel();
                    inspectorViewModel.Hora =inspeccion.Fecha.Value.ToShortTimeString();
                    inspectorViewModel.Interno =  inspeccion.Interno.ToString();
                    li.Add(inspectorViewModel);
                }

                return RespuestaViewModel.OK(li);
            }
            catch (Exception ex)
            {
                return RespuestaViewModel.Error(ex);
            }

        }

    }
}
