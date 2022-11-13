using System;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.Security;
using Microsoft.AspNet.Identity;
using SMS.Models;
using DataLayer.Models;
using DataLayer.Context;

using DataLayer.Context;
using DataLayer.Repositories;
using DataLayer.Services;

namespace SMS.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
        
        private IRoleRepository _role;
        private IAccountRepository _account;
       
        public AccountController(IRoleRepository role, IAccountRepository account)
        {
            _role = role;
            _account = account;
            

        }

        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return PartialView();
        }

        
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Login(Account model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }
            
            Role role = new Role();
            Account account;
            bool verify = false;
           
            Role teacher = _role.GetAllRole(r => r.Name == "استاد").FirstOrDefault();
            Role student = _role.GetAllRole(r => r.Name == "دانشجو").FirstOrDefault();
            if (model.RoleID == teacher.Sysid)
            {
                account = _account.GetAllAccount(x => x.Teacher.Id == model.Student.Id).FirstOrDefault();
                if (account != null)
                {
                    if (model.Password== account.Password)
                    {
                        verify = true;
                    }
                    else
                    {
                        verify = false;
                    }
                    
                }
            }

            else if (model.RoleID == student.Sysid)
            {
                account = _account.GetAllAccount(x => x.Student.Id == model.Student.Id).FirstOrDefault();

                if (account != null)
                {
                    if (model.Password == account.Password)
                    {
                        verify = true;
                    }
                    else
                    {
                        verify = false;
                    }
                    
                }
            }
            else
            {
                account = null;
            }
            foreach (var modelValue in ModelState.Values)
            {
                modelValue.Errors.Clear();
            }
            if (verify == true)
            {
               

                if (account.Role.Name == "استاد")
                {
                    Session["Role"] = "استاد";
                    Session["ID"] = account.TeacherID;
                    Session["TeacherSysID"] = account.Teacher.Sysid;
                    Session["Name"] = account.Teacher.FullName;
                    Session["Photo"] = account.Teacher.Photo;
                    Session["RoleName"] = account.Role.Name;
                    Session["RoleID"] = account.Role.Sysid;
                    FormsAuthentication.SetAuthCookie(account.Teacher.Id, false);
                    return RedirectToAction("Index", "Home");
                }
                else if (account.Role.Name == "دانشجو")
                {
                    Session["Role"] = "دانشجو";
                    Session["ID"] = account.StudentID;
                    Session["Name"] = account.Student.FullName;
                    Session["Photo"] = account.Student.Photo;
                    Session["RoleName"] = account.Role.Name;
                    Session["RoleID"] = account.Role.Sysid;
                    FormsAuthentication.SetAuthCookie(account.Student.Id, false);
                    return RedirectToAction("Index", "CourseStudent");
                }
               
                else
                {
                    ModelState.AddModelError("", "شناسه کاربری یا رمز عبور صحیح نیست");
                    return RedirectToAction("Login", "Account");
                }

            }
            else
            {
                ModelState.AddModelError("", "شناسه کاربری یا رمز عبور صحیح نیست.");
                return View(model);
            }
        }

    }
}