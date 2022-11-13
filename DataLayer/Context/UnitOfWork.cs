using DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Context
{
    public class UnitOfWork : IDisposable
    {
        SMSEntities db = new SMSEntities();

        private MyGenericRepository<Course> courseRepository;
        public MyGenericRepository<Course> CourseRepository
        {
            get
            {
                if (courseRepository == null)
                {
                    courseRepository = new MyGenericRepository<Course>(db);
                }
                return courseRepository;
            }
        }

        private MyGenericRepository<Account> accountRepository;
        public MyGenericRepository<Account> AccountRepository
        {
            get
            {
                if (accountRepository == null)
                {
                    accountRepository = new MyGenericRepository<Account>(db);
                }
                return accountRepository;
            }
        }

        private MyGenericRepository<Hours> hoursRepository;
        public MyGenericRepository<Hours> HoursRepository
        {
            get
            {
                if (hoursRepository == null)
                {
                    hoursRepository = new MyGenericRepository<Hours>(db);
                }
                return hoursRepository;
            }
        }

        private MyGenericRepository<Invitation> invitationRepository;
        public MyGenericRepository<Invitation> InvitationRepository
        {
            get
            {
                if (invitationRepository == null)
                {
                    invitationRepository = new MyGenericRepository<Invitation>(db);
                }
                return invitationRepository;
            }
        }

        private MyGenericRepository<MenuItem> menuItemRepository;
        public MyGenericRepository<MenuItem> MenuItemRepository
        {
            get
            {
                if (menuItemRepository == null)
                {
                    menuItemRepository = new MyGenericRepository<MenuItem>(db);
                }
                return menuItemRepository;
            }
        }

        private MyGenericRepository<NameOfCourse> nameOfCourseRepository;
        public MyGenericRepository<NameOfCourse> NameOfCourseRepository
        {
            get
            {
                if (nameOfCourseRepository == null)
                {
                    nameOfCourseRepository = new MyGenericRepository<NameOfCourse>(db);
                }
                return nameOfCourseRepository;
            }
        }

        private MyGenericRepository<Role> roleRepository;
        public MyGenericRepository<Role> RoleRepository
        {
            get
            {
                if (roleRepository == null)
                {
                    roleRepository = new MyGenericRepository<Role>(db);
                }
                return roleRepository;
            }
        }

        private MyGenericRepository<RoleMenu> roleMenuRepository;
        public MyGenericRepository<RoleMenu> RoleMenuRepository
        {
            get
            {
                if (roleMenuRepository == null)
                {
                    roleMenuRepository = new MyGenericRepository<RoleMenu>(db);
                }
                return roleMenuRepository;
            }
        }

        private MyGenericRepository<Student> studentRepository;
        public MyGenericRepository<Student> StudentRepository
        {
            get
            {
                if (studentRepository == null)
                {
                    studentRepository = new MyGenericRepository<Student>(db);
                }
                return studentRepository;
            }
        }

        private MyGenericRepository<Teach> teachRepository;
        public MyGenericRepository<Teach> TeachRepository
        {
            get
            {
                if (teachRepository == null)
                {
                    teachRepository = new MyGenericRepository<Teach>(db);
                }
                return teachRepository;
            }
        }

        private MyGenericRepository<Teacher> teacherRepository;
        public MyGenericRepository<Teacher> TeacherRepository
        {
            get
            {
                if (teacherRepository == null)
                {
                    teacherRepository = new MyGenericRepository<Teacher>(db);
                }
                return teacherRepository;
            }
        }

        private MyGenericRepository<Weekdays> weekdaysRepository;
        public MyGenericRepository<Weekdays> WeekdaysRepository
        {
            get
            {
                if (weekdaysRepository == null)
                {
                    weekdaysRepository = new MyGenericRepository<Weekdays>(db);
                }
                return weekdaysRepository;
            }
        }
        public void Dispose()
        {
            db.Dispose();
        }
        public void Save()
        {
            db.SaveChanges();
        }
    }
}
