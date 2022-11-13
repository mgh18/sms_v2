using SMS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DataLayer.Models;
using DataLayer.Context;

using DataLayer.Repositories;
using DataLayer.Services;

namespace SMS.Controllers
{
   
    public class HomeController : Controller
    {
       
        private IStudentRepository _student;
        private ITeachRepository _teach;

        public HomeController(IStudentRepository student, ITeachRepository teach)
        {
            _student = student;
            _teach = teach; 
        }
        public ActionResult Index()
        {
            int ID = Convert.ToInt32(Session["ID"]);
            
             if (Session["RoleName"].ToString() == "استاد")
                {
                    int courses = _teach.Get(x => x.TeacherID == ID).Select(x => x.CourseID).Count();
                    ViewBag.totalStudents = _student.GetAllStudent().Count();
                    ViewBag.courses = courses;     
                }
            
            return View();
        }
 
    }
}