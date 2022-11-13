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

namespace SMS.Controllers
{
    
    public class StudentController : Controller
    {
        
        private IStudentRepository _student;
        public StudentController(IStudentRepository student)
        {
            _student = student;

        }

        // GET: Students
        public ActionResult Index()
        {
            
            IEnumerable<Student> student = null;
            if (Session["Role"].ToString() == "استاد")
            {
                student = _student.GetAllStudent();
                return View(student.ToList());
            }

            
            if (student != null)
            {
                return View(student.ToList());
            }
            else
            {
                return View();
            }

        }

        // GET: Students/Details/
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Student student = _student.GetStudentById(id.Value);
            if (student == null)
            {
                return HttpNotFound();
            }
            return View(student);
        }

  
       
    }
}
