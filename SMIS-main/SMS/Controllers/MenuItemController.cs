using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using SMS.Models;
using DataLayer.Models;
namespace SMS.Controllers
{
    public class MenuItemController : Controller
    {
       

        
        public ActionResult SideMenu()
        {
           
            return PartialView();
        }

    }
}
