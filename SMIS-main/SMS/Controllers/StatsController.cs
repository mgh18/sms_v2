using Microsoft.Ajax.Utilities;
using SMS.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net.NetworkInformation;
using System.Security.Permissions;
using System.Security.Policy;
using System.Web;
using System.Web.Mvc;
using DataLayer.Models;
using DataLayer.Context;
using DataLayer.Repositories;

namespace SMS.Controllers
{
    [Authorize(Roles = "استاد")]
    public class StatsController : Controller
    {
        
        private IInvitationRepository _invitation;
        public StatsController(IInvitationRepository invitation)
        {
            _invitation = invitation;

        }
        // GET: Invitation
        public ActionResult Index()
        {
            int id = Convert.ToInt32(Session["ID"]);
          
            IEnumerable<GetStatModel> invitation = null;

            invitation = from Invitation in _invitation.GetAllInvitation()
                         where Invitation.Teacher_ID == id
                         group new { Invitation.Course, Invitation } by new
                         {
                             Invitation.Course.NameOfCourse.Course_Title
                         } into g
                         select new GetStatModel
                         {
                             Name = g.Key.Course_Title,
                             invited_students = g.Count(p => p.Invitation.Invite != null),
                             accepted = g.Count(p => p.Invitation.IsAccepted == true),
                             Percentage = (Double)Math.Round((double)100.0 * g.Count(p => p.Invitation.IsAccepted ==true) / g.Count(p => p.Invitation.Invite != null), 1),
                             // weighted_avg =  g.Count(p => p.Invitation.Invite != null) * g.Count(p => p.Invitation.IsAccepted != null) / g.Count(p => p.Invitation.Invite != null)
                             weighted_avg = ((Double)(g.Count(p => p.Invitation.Invite != null) * g.Count(p => p.Invitation.IsAccepted != null)) /
                            (from i0 in _invitation.GetAllInvitation()
                             where
                                    i0.Teacher_ID == id
                            select new
                                {
                                    i0.Invite
                                }).Count(p => p.Invite != null))

                          };





            var maxim = invitation.Max(p => p.weighted_avg);
            var minim = invitation.Min(p => p.weighted_avg);
            var popular = invitation.Where(p => p.weighted_avg == maxim).Select(p => p.Name);
            ViewBag.mostfav = popular.ToList();

            if (maxim != minim)
            {

                var leastfav = invitation.Where(p => p.weighted_avg == minim).Select(p => p.Name);
                ViewBag.leastfav = leastfav.ToList();
            }
            else if (maxim == 0 && minim == 0)
            {
                var leastfav = "";
                ViewBag.mostfav = leastfav.ToList();
                ViewBag.leastfav = leastfav.ToList();
            }
            else
            {
                var leastfav = "";
                ViewBag.leastfav = leastfav.ToList();
            }

            return View(invitation.ToList());

        }
    }

   
}