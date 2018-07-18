using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using System.Web.Http.Description;
using BusInspector.Data;

namespace BusInspector.Repository.Repository
{
    public class InspectorRepository
    {

        BusInspector.Data.BusInspectorEntities _context;

        public object RespuestaViewModel { get; private set; }

        public InspectorRepository()
        {
            _context = new BusInspector.Data.BusInspectorEntities();            
        }

        public async Task<bool> Validar(string username, string password)
        {
            try
            {
                //LogRepository.Agregar(LogRepository.eTipoLog.Informacion, "validar(" + username + "," + password + ")");

                
                decimal dni = decimal.Parse(username);
                decimal legajo = decimal.Parse(password);

                bool usValido = _context.Inspectors.Where(x => x.legajo== legajo && x.dni==dni && x.FechaBaja==null).Count() > 0;

                if (usValido)
                { return usValido;}
                return false;


            }
            catch (Exception ex)
            {
                LogRepository.Agregar(LogRepository.eTipoLog.Error, "Error: " + ex.Message.ToString());
                return false;
            }
        }
       
        
    }
}