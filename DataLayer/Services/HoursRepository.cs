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
    public class HoursRepository : IHoursRepository
    {
        private SMSEntities db;

        private DbSet<Hours> _dbset;
        public HoursRepository(SMSEntities context)
        {
            db = context;

            _dbset = context.Set<Hours>();

        }

        public void DeleteHours(Hours hours)
        {
            if (db.Entry(hours).State == EntityState.Detached)
            {
                _dbset.Attach(hours);
            }
            _dbset.Remove(hours);
        }

        public void DeleteHours(int HoursId)
        {
            var entity = GetHoursById(HoursId);
            DeleteHours(entity);
        }

        public virtual IEnumerable<Hours> GetAllHours(Expression<Func<Hours, bool>> where = null, Func<IQueryable<Hours>, IOrderedQueryable<Hours>> orderby = null, string includes = "")
        {
            IQueryable<Hours> query = _dbset;

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


        public Hours GetHoursById(int HoursId)
        {
            return _dbset.Find(HoursId);
        }

        public void InsertHours(Hours hours)
        {
            _dbset.Add(hours);
        }

        public void Save()
        {
            db.SaveChanges();
        }

        public void UpdateHours(Hours hours)
        {
            _dbset.Attach(hours);
            db.Entry(hours).State = EntityState.Modified;
        }


    }
}
