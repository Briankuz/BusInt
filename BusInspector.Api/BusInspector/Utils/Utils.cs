using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BusInspector.Utils
{
    public class Utils
    {
        public static string toStringJson(object obj)
        {
            return Newtonsoft.Json.JsonConvert.SerializeObject(obj);
        }
    }
}