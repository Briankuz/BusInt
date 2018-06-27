using System.Web.Mvc;

namespace BusInspector.Web.Models
{
    public class MyAuthorizeAdmin : FilterAttribute, IAuthorizationFilter
    {

        public void OnAuthorization(AuthorizationContext filterContext)
        {
            if (System.Web.HttpContext.Current.Session["IdUsuario"] == null)
            {

                filterContext.Result = new RedirectResult(string.Format("/Home/Index", filterContext.HttpContext.Request.Url.AbsolutePath));

            }
        }
    }
}