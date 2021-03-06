﻿using BusInspector.Data;
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
        public async Task<RespuestaViewModel> GetInspecciones(int inspector, int seccion)
        {
            try
            {
                //falta filtro por dia actual
                DateTime today = DateTime.Now.Date;

                var inspecciones = db.Inspeccions.OrderByDescending(m=>m.Fecha).Where(m => m.Inspector == inspector && m.Seccion==seccion && (m.Fecha.Value.Year == today.Year && m.Fecha.Value.Month == today.Month && m.Fecha.Value.Day == today.Day)).Take(10).ToList();
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
        [Route("api/Inspector/me")]
        [Authorize]
        [ResponseType(typeof(RespuestaViewModel))]
        public async Task<RespuestaViewModel> GetInspector(decimal dni, decimal legajo)
        {
            try
            {
                Inspector inspector = db.Inspectors.Where(m => m.dni == dni && m.legajo == legajo).FirstOrDefault();
                return RespuestaViewModel.OK(new { id = inspector.id, nombre = inspector.nombre });
            }
            catch (Exception ex)
            {

                return RespuestaViewModel.Error(ex);
            }

        }

    }
}
