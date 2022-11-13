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
    public class WeekdaysRepository : IWeekdaysRepository
    {
        private SMSEntities db;

        private DbSet<Weekdays> _dbset;
        public WeekdaysRepository(SMSEntities context)
        {
            db = context;

            _dbset = context.Set<Weekdays>();

        }

        public void DeleteWeekdays(Weekdays weekdays)
        {
            if (db.Entry(weekdays).State == EntityState.Detached)
            {
                _dbset.Attach(weekdays);
            }
            _dbset.Remove(weekdays);
        }

        public void DeleteWeekdays(int WeekdaysId)
        {
            var entity = GetWeekdaysById(WeekdaysId);
            DeleteWeekdays(entity);
        }

        public virtual IEnumerable<Weekdays> GetAllWeekdays(Expression<Func<Weekdays, bool>> where = null, Func<IQueryable<Weekdays>, IOrderedQueryable<Weekdays>> orderby = null, string includes = "")
        {
            IQueryable<Weekdays> query = _dbset;

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


        public Weekdays GetWeekdaysById(int WeekdaysId)
        {
            return _dbset.Find(WeekdaysId);
        }

        public void InsertWeekdays(Weekdays weekdays)
        {
            _dbset.Add(weekdays);
        }

      

        public void Save()
        {
            db.SaveChanges();
        }

        public void UpdateWeekdays(Weekdays weekdays)
        {
            _dbset.Attach(weekdays);
            db.Entry(weekdays).State = EntityState.Modified;
        }


    }
}
