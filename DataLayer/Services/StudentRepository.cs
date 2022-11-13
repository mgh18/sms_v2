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
    public class StudentRepository : IStudentRepository
    {
        private SMSEntities db;

        private DbSet<Student> _dbset;
        public StudentRepository(SMSEntities context)
        {
            db = context;

            _dbset = context.Set<Student>();

        }

        public void DeleteStudent(Student student)
        {
            if (db.Entry(student).State == EntityState.Detached)
            {
                _dbset.Attach(student);
            }
            _dbset.Remove(student);
        }

        public void DeleteStudent(int StudentId)
        {
            var entity = GetStudentById(StudentId);
            DeleteStudent(entity);
        }

        public virtual IEnumerable<Student> GetAllStudent(Expression<Func<Student, bool>> where = null, Func<IQueryable<Student>, IOrderedQueryable<Student>> orderby = null, string includes = "")
        {
            IQueryable<Student> query = _dbset;

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


        public Student GetStudentById(int StudentId)
        {
            return _dbset.Find(StudentId);
        }

        public void InsertStudent(Student student)
        {
            _dbset.Add(student);
        }

        public void Save()
        {
            db.SaveChanges();
        }

        public void UpdateStudent(Student student)
        {
            _dbset.Attach(student);
            db.Entry(student).State = EntityState.Modified;
        }


    }
}
