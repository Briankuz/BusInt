using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BusInspector.Data;


namespace BusInspector.Repository.Repository
{
    public static class LogRepository
    {
        public enum  eTipoLog : int
        {
            Informacion = 0,
            Error =1
          
        }
        private static BusInspectorEntities _db = new BusInspectorEntities();
        public static void Agregar(eTipoLog tipo, string descripcion)
        {
            log l = new log();
            l.descripcion = descripcion;
            l.fecha = DateTime.Now;
            l.tipo =(int)tipo;
            _db.logs.Add(l);

            _db.SaveChanges();          
                        
        }

        
    }
}