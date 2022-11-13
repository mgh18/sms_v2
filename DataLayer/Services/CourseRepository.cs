using DataLayer.Models;
using DataLayer.Repositories;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using System.Runtime.Remoting.Contexts;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Services
{
    public class CourseRepository : ICourseRepository
    {
        private SMSEntities db;

        private DbSet<Course> _dbset;
        public CourseRepository(SMSEntities context)
        {
            db = context;

            _dbset = context.Set<Course>();

        }

        public void DeleteCourse(Course course)
        {
            if (db.Entry(course).State == EntityState.Detached)
            {
                _dbset.Attach(course);
            }
            _dbset.Remove(course);
        }

        public void DeleteCourse(int CourseId)
        {
            var entity = GetCourseById(CourseId);
            DeleteCourse(entity);
        }

       

        public virtual IEnumerable<Course> Get(Expression<Func<Course, bool>> where = null, Func<IQueryable<Course>, IOrderedQueryable<Course>> orderby = null, string includes = "")
        {
            IQueryable<Course> query = _dbset;

            if (where != null)
            {
                query = query.Where(where);
            }
            if (orderby != null)
            {
                query = orderby(query);
            }
            if (includes != "")
            {
                foreach (string include in includes.Split(','))
                {
                    query = query.Include(include);
                }
            }


            return query.ToList();

        }


        public Course GetCourseById(int CourseId)
        {
            return _dbset.Find(CourseId);
        }

        public void InsertCourse(Course course)
        {
            _dbset.Add(course);
        }

        public void Save()
        {
            db.SaveChanges();
        }

        public void UpdateCourse(Course course)
        {
            _dbset.Attach(course);
            db.Entry(course).State = EntityState.Modified;
        }


    }
}
