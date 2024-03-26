using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace PRN211_Assignment3Web.Controllers
{
    public class BaseController : Controller
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            string userName = HttpContext.Session.GetString("UserName");
            ViewBag.UserName = userName;

            base.OnActionExecuting(context);
        }

    }
}
