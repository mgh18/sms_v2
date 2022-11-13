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
    [Authorize(Roles = "استاد")]
    public class CourseController : Controller
    {
      
        UnitOfWork db = new UnitOfWork();

        private ICourseRepository _course;
        private IHoursRepository _hours;
        private IWeekdaysRepository _weekdays;
        private INameOfCourseRepository _nameOfCourse;
        private ITeachRepository _teach;
        public CourseController(ICourseRepository course, IHoursRepository hours, IWeekdaysRepository weekdays, INameOfCourseRepository nameOfCourse,ITeachRepository teach)
        {
            _course = course;
            _hours = hours;
            _weekdays = weekdays;
            _nameOfCourse = nameOfCourse;
            _teach = teach;
        }



        // GET: Courses
        public ActionResult Index()
        {
            int TID = Convert.ToInt32(Session["ID"]);
            int id = Convert.ToInt32(Session["ID"]);
            _course.Get(includes: "Weekdays");
            _course.Get(includes: "Hours");
            var courses = _teach.Get(x => x.TeacherID == id).Select(x => x.Course);

            ViewBag.Day_Name = new SelectList(_weekdays.GetAllWeekdays(), "Sysid", "DayName");
            ViewBag.Hour_Name = new SelectList(_hours.GetAllHours(), "Sysid", "HoursTitle");
            ViewBag.Course_Title = new SelectList(_nameOfCourse.GetAllNameOfCourse(), "Sysid", "Course_Title");

            return View(courses.ToList());
        }
        // GET: Courses/Create
        public ActionResult Create()
        {
            int id = Convert.ToInt32(Session["ID"]);

            ViewBag.Day_Name = new SelectList(_weekdays.GetAllWeekdays(), "Sysid", "DayName");
            ViewBag.Hour_Name = new SelectList(_hours.GetAllHours(), "Sysid", "HoursTitle");
            ViewBag.Course_Title = new SelectList(_nameOfCourse.GetAllNameOfCourse(), "Sysid", "Course_Title");

            return View();
        }
        // POST: Courses/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Course course)
        {

            if (ModelState.IsValid)
            {
                course.CreatedBy = Convert.ToInt32(Session["ID"]);
                db.CourseRepository.Insert(course);
                Teach te = new Teach();

                te.TeacherID = Convert.ToInt32(Session["ID"]);
                te.CourseID = course.Sysid;
                db.TeachRepository.Insert(te);
                try
                {
                    db.CourseRepository.Save();
                }
                catch
                {
                    TempData["msg"] = "<script>alert('این دوره با دوره های پیشین تداخل دارد.');</script>";
                    return RedirectToAction("Index");
                }
                return RedirectToAction("Index");
            }
            return View(course);
        }
        // GET: Courses/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            
            Course course = _course.GetCourseById(id.Value);
            if (course == null)
            {
                return HttpNotFound();
            }
            return View(course);
        }



        // GET: Courses/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            
            Course course = _course.GetCourseById(id.Value);
            if (course == null)
            {
                return HttpNotFound();
            }
            ViewBag.Day_Name = new SelectList(_weekdays.GetAllWeekdays(), "Sysid", "DayName");
            ViewBag.Hour_Name = new SelectList(_hours.GetAllHours(), "Sysid", "HoursTitle");
            ViewBag.Course_Title = new SelectList(_nameOfCourse.GetAllNameOfCourse(), "Sysid", "Course_Title");
            return View(course);
        }

        // POST: Courses/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Course course)
        {
            if (ModelState.IsValid)
            {
                course.CreatedBy = Convert.ToInt32(Session["ID"]);

               
                _course.UpdateCourse(course);
                try
                {
                    _course.Save();
                }
                catch
                {
                    TempData["msg"] = "<script>alert('این دوره با دوره های پیشین تداخل دارد.');</script>";

                    return RedirectToAction("Index");
                }
                return RedirectToAction("Index");
            }

            return View(course);
        }


    }
}
