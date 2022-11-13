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
    public class MenuItemRepository : IMenuItemRepository
    {
        private SMSEntities db;

        private DbSet<MenuItem> _dbset;
        public MenuItemRepository(SMSEntities context)
        {
            db = context;

            _dbset = context.Set<MenuItem>();

        }

        public void DeleteMenuItem(MenuItem menuItem)
        {
            if (db.Entry(menuItem).State == EntityState.Detached)
            {
                _dbset.Attach(menuItem);
            }
            _dbset.Remove(menuItem);
        }

        public void DeleteMenuItem(int MenuItemId)
        {
            var entity = GetMenuItemById(MenuItemId);
            DeleteMenuItem(entity);
        }

        public virtual IEnumerable<MenuItem> GetAllMenuItem(Expression<Func<MenuItem, bool>> where = null, Func<IQueryable<MenuItem>, IOrderedQueryable<MenuItem>> orderby = null, string includes = "")
        {
            IQueryable<MenuItem> query = _dbset;

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


        public MenuItem GetMenuItemById(int MenuItemId)
        {
            return _dbset.Find(MenuItemId);
        }

        public void InsertMenuItem(MenuItem menuItem)
        {
            _dbset.Add(menuItem);
        }

        public void Save()
        {
            db.SaveChanges();
        }

        public void UpdateMenuItem(MenuItem menuItem)
        {
            _dbset.Attach(menuItem);
            db.Entry(menuItem).State = EntityState.Modified;
        }


    }
}
