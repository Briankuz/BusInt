using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace IkeApp.Data
{
    public class Id
    {
        public int tipo { get; set; }
        public string numero { get; set; }

        public Id(int tipo, string numero)
        {
            this.tipo = tipo;
            this.numero = numero;
        }

        public static Id newId(int? tipo, string numero)
        {
            if (tipo == null || numero == null)
                throw new Exception("El tipo o numero es null");
            else
                return new Id((int)tipo, numero.ToString());
        }
        public bool IgualA(Id id)
        {
            return this.tipo == id.tipo && this.numero.Equals(id.numero);
        }

    }
}