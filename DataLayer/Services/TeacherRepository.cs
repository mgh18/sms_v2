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
    public class TeacherRepository : ITeacherRepository
    {
        private SMSEntities db;

        private DbSet<Teacher> _dbset;
        public TeacherRepository(SMSEntities context)
        {
            db = context;

            _dbset = context.Set<Teacher>();

        }

        public void DeleteTeacher(Teacher teacher)
        {
            if (db.Entry(teacher).State == EntityState.Detached)
            {
                _dbset.Attach(teacher);
            }
            _dbset.Remove(teacher);
        }

        public void DeleteTeacher(int TeacherId)
        {
            var entity = GetTeacherById(TeacherId);
            DeleteTeacher(entity);
        }

        public virtual IEnumerable<Teacher> GetAllTeacher(Expression<Func<Teacher, bool>> where = null, Func<IQueryable<Teacher>, IOrderedQueryable<Teacher>> orderby = null, string includes = "")
        {
            IQueryable<Teacher> query = _dbset;

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


        public Teacher GetTeacherById(int TeacherId)
        {
            return _dbset.Find(TeacherId);
        }

        public void InsertTeacher(Teacher teacher)
        {
            _dbset.Add(teacher);
        }

        public void Save()
        {
            db.SaveChanges();
        }

        public void UpdateTeacher(Teacher teacher)
        {
            _dbset.Attach(teacher);
            db.Entry(teacher).State = EntityState.Modified;
        }


    }
}
