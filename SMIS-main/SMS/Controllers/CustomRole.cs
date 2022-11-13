using SMS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.ExceptionServices;
using System.Web;
using System.Web.Http.Results;
using System.Web.Security;
using DataLayer.Models;
using DataLayer.Context;


using DataLayer.Context;
using DataLayer.Repositories;
using DataLayer.Services;

namespace SMS.Controllers
{
    
    public class CustomRole : RoleProvider
   {
       
        public override string ApplicationName { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

       public override void CreateRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            throw new NotImplementedException();
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            throw new NotImplementedException();
        }

        public override string[] GetAllRoles()
        {
            throw new NotImplementedException();
        }

        
            public override string[] GetRolesForUser(string username) {

            UnitOfWork db = new UnitOfWork();
           

            string student_role=null;
            string teacher_role=null;
            Teacher t;
            Student s;
            t = db.TeacherRepository.Get(x => x.Id == username).FirstOrDefault();
            s = db.StudentRepository.Get(x => x.Id == username).FirstOrDefault();
            
            if (s != null)
            {
                student_role = db.StudentRepository.Get(x => x.Id == username).FirstOrDefault().Role1.Name;
                string[] result = { student_role };
                return result;
            }
            else if(t != null)
            {
                teacher_role = db.TeacherRepository.Get(x => x.Id == username).FirstOrDefault().Role1.Name;
                string[] result = { teacher_role };
                return result;
            }
            else
            {
                return null;
            }

        }

        private void GetType(string student_role)
        {
            throw new NotImplementedException();
        }

        public override string[] GetUsersInRole(string roleName) { 
        throw new NotImplementedException();
        }

        public override bool IsUserInRole(string username, string roleName)
        {
            throw new NotImplementedException();
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override bool RoleExists(string roleName)
        {
            throw new NotImplementedException();
        }
    }
}