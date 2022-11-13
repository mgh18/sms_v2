using DataLayer.Models;
using DataLayer.Repositories;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Diagnostics;
using System.Linq;
using System.Linq.Expressions;
using System.Runtime.Remoting.Contexts;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Services
{
    public class TeachRepository : ITeachRepository
    {
        private SMSEntities db;

        private DbSet<Teach> _dbset;
        public TeachRepository(SMSEntities context)
        {
            db = context;

            _dbset = context.Set<Teach>();

        }

        public void DeleteTeach(Teach teach)
        {
            if (db.Entry(teach).State == EntityState.Detached)
            {
                _dbset.Attach(teach);
            }
            _dbset.Remove(teach);
        }

        public void DeleteTeach(int TeachId)
        {
            var entity = GetTeachById(TeachId);
            DeleteTeach(entity);
        }

        public virtual IEnumerable<Teach> Get(Expression<Func<Teach, bool>> where = null, Func<IQueryable<Teach>, IOrderedQueryable<Teach>> orderby = null, string includes = "")
        {
            IQueryable<Teach> query = _dbset;

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


        public Teach GetTeachById(int TeachId)
        {
            return _dbset.Find(TeachId);
        }

        public void InsertTeach(Teach teach)
        {
            _dbset.Add(teach);
        }

        public void Save()
        {
            db.SaveChanges();
        }

        public void UpdateTeach(Teach teach)
        {
            _dbset.Attach(teach);
            db.Entry(teach).State = EntityState.Modified;
        }


    }
}
