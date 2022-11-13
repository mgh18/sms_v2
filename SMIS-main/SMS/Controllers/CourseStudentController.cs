using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using SMS.Models;
using DataLayer.Models;
using DataLayer.Context;

using DataLayer.Context;
using DataLayer.Repositories;
using DataLayer.Services;

namespace SMS.Controllers
{
    [Authorize(Roles = "دانشجو")]
    public class CourseStudentController : Controller
    {
        

        private IInvitationRepository _invitation;
        private IWeekdaysRepository _weekdays;
        private IHoursRepository _hours;
       
        public CourseStudentController(IInvitationRepository invitation, IWeekdaysRepository weekdays, IHoursRepository hours)
        {
            _invitation = invitation;
            _weekdays = weekdays;
            _hours = hours;
 
        }


        // GET: CoursesStudent
        public ActionResult Index()
        {

            int id = Convert.ToInt32(Session["ID"]);
            IEnumerable<Invitation> invitation = null;

            invitation = _invitation.GetAllInvitation(x => x.Student_ID == id);

            ViewBag.Day_Name = new SelectList(_weekdays.GetAllWeekdays(), "Sysid", "DayName");
            ViewBag.Hour_Name = new SelectList(_hours.GetAllHours(), "Sysid", "HoursTitle");

            return View(invitation.ToList());
        }

        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Invitation invitation = _invitation.GetInvitationById(id.Value);
            if (invitation == null)
            {
                return HttpNotFound();
            }

            invitation.Student_ID = Convert.ToInt32(Session["ID"]);
            if (invitation.IsAccepted==null || invitation.IsAccepted==false)
            {
                invitation.IsAccepted = true;
                _invitation.Save();
            }
            else
            {
                invitation.IsAccepted = false;
                _invitation.Save();
            }
            return RedirectToAction("Index");
        }

      

    } 
}
