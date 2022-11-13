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
using DataLayer.Context;


using DataLayer.Repositories;
using DataLayer.Services;

namespace SMS.Controllers
{
    [Authorize(Roles = "استاد")]
    public class InvitationController : Controller
    {
       

        private ICourseRepository _course;
        private IInvitationRepository _invitation;
        private IStudentRepository _student;
        private INameOfCourseRepository _nameOfCourse;
        private ITeachRepository _teach;
        public InvitationController(ICourseRepository course, IInvitationRepository invitation, IStudentRepository student, INameOfCourseRepository nameOfCourse, ITeachRepository teach)
        {
            _course = course;
            _invitation = invitation;
            _student = student;
            _nameOfCourse = nameOfCourse;
            _teach = teach;

        }


        // GET: Invitation
        public ActionResult Index()
        {
            int id = Convert.ToInt32(Session["ID"]);
            IEnumerable<Invitation> invitation = null;
            
            invitation = _invitation.GetAllInvitation(x => x.Teacher_ID == id);
            ViewBag.Course_Title = new SelectList(_nameOfCourse.GetAllNameOfCourse(), "Sysid", "Course_Title");

            return View(invitation.ToList());
              
          
        }
        public ActionResult Create()
        {
            int id = Convert.ToInt32(Session["ID"]);
            ViewBag.Course_Name = new SelectList(_teach.Get(x => x.TeacherID == id).Select(x => x.Course.NameOfCourse), "Sysid", "Course_Title");
            ViewBag.Student_Name = new SelectList(_student.GetAllStudent(), "Sysid", "FullName");
            ViewBag.Course_Title = new SelectList(_nameOfCourse.GetAllNameOfCourse(), "Sysid", "Course_Title");

            return View();
        }

       
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Invitation invitation)
        {
            if (ModelState.IsValid)
            {
                //numerable<Invitation> temp = null;
                int id = Convert.ToInt32(Session["ID"]);
                invitation.Teacher_ID = Convert.ToInt32(Session["ID"]);
                _invitation.GetAllInvitation(includes:"Student").ToList();
                _invitation.GetAllInvitation(includes:"Course").ToList();
                invitation.Invite = true;
                invitation.Course_ID = _course.Get(x => x.Name == invitation.Course_ID).Select(x => x.Sysid).FirstOrDefault();

                _invitation.InsertInvitation(invitation);
                try
                {
                    _invitation.Save();
                }
                catch
                {
                    TempData["msg"] = "<script>alert('دانشجو قبلا به این دوره دعوت شده است.');</script>";
                    return RedirectToAction("Index");
                }
               
                return RedirectToAction("Index");

            }

            return View(invitation.ToString());
        } 
    }
}
