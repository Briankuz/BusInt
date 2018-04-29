using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using BusInspector.Repository.Repository;
using Microsoft.Owin.Security.OAuth;

namespace BusInspector.Providers
{
    public class SimpleAuthorizationServerProvider : OAuthAuthorizationServerProvider
    {
        public override async Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            
            ////////////////////////////////////////////////////////
            string clientId = "";
            string clientSecret = "";

            context.TryGetFormCredentials(out clientId, out clientSecret);
            if (clientId != "_BusInspector1234$_")
                context.Rejected();
            else
                context.Validated();
        }

        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {
            context.OwinContext.Response.Headers.Add("Access-Control-Allow-Origin", new[] { "*" });
            
            InspectorRepository ur = new InspectorRepository();
            var ok =await ur.Validar(context.UserName, context.Password);           
            if (!ok)            
            {
                context.SetError("Invalido", "El nombre de usuario o constraseña es incorrecto");
                return;
            }
                        
            var identity = new ClaimsIdentity(context.Options.AuthenticationType);
            identity.AddClaim(new Claim("sub", context.UserName));
            identity.AddClaim(new Claim("role", "user"));

            context.Validated(identity);
        }
    }
}