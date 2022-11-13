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
    public class RoleMenuRepository : IRoleMenuRepository
    {
        private SMSEntities db;

        private DbSet<RoleMenu> _dbset;
        public RoleMenuRepository(SMSEntities context)
        {
            db = context;

            _dbset = context.Set<RoleMenu>();

        }

        public void DeleteRoleMenu(RoleMenu roleMenu)
        {
            if (db.Entry(roleMenu).State == EntityState.Detached)
            {
                _dbset.Attach(roleMenu);
            }
            _dbset.Remove(roleMenu);
        }

        public void DeleteRoleMenu(int RoleMenuId)
        {
            var entity = GetRoleMenuById(RoleMenuId);
            DeleteRoleMenu(entity);
        }

        public virtual IEnumerable<RoleMenu> GetAllRoleMenu(Expression<Func<RoleMenu, bool>> where = null, Func<IQueryable<RoleMenu>, IOrderedQueryable<RoleMenu>> orderby = null, string includes = "")
        {
            IQueryable<RoleMenu> query = _dbset;

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


        public RoleMenu GetRoleMenuById(int RoleMenuId)
        {
            return _dbset.Find(RoleMenuId);
        }

        public void InsertRoleMenu(RoleMenu roleMenu)
        {
            _dbset.Add(roleMenu);
        }

        public void Save()
        {
            db.SaveChanges();
        }

        public void UpdateRoleMenu(RoleMenu roleMenu)
        {
            _dbset.Attach(roleMenu);
            db.Entry(roleMenu).State = EntityState.Modified;
        }


    }
}
