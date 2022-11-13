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
    public class NameOfCourseRepository : INameOfCourseRepository
    {
        private SMSEntities db;

        private DbSet<NameOfCourse> _dbset;
        public NameOfCourseRepository(SMSEntities context)
        {
            db = context;

            _dbset = context.Set<NameOfCourse>();

        }

        public void DeleteNameOfCourse(NameOfCourse nameOfCourse)
        {
            if (db.Entry(nameOfCourse).State == EntityState.Detached)
            {
                _dbset.Attach(nameOfCourse);
            }
            _dbset.Remove(nameOfCourse);
        }

        public void DeleteNameOfCourse(int NameOfCourseId)
        {
            var entity = GetNameOfCourseById(NameOfCourseId);
            DeleteNameOfCourse(entity);
        }

        public virtual IEnumerable<NameOfCourse> GetAllNameOfCourse(Expression<Func<NameOfCourse, bool>> where = null, Func<IQueryable<NameOfCourse>, IOrderedQueryable<NameOfCourse>> orderby = null, string includes = "")
        {
            IQueryable<NameOfCourse> query = _dbset;

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


        public NameOfCourse GetNameOfCourseById(int NameOfCourseId)
        {
            return _dbset.Find(NameOfCourseId);
        }

        public void InsertNameOfCourse(NameOfCourse nameOfCourse)
        {
            _dbset.Add(nameOfCourse);
        }

        public void Save()
        {
            db.SaveChanges();
        }

        public void UpdateNameOfCourse(NameOfCourse nameOfCourse)
        {
            _dbset.Attach(nameOfCourse);
            db.Entry(nameOfCourse).State = EntityState.Modified;
        }


    }
}
