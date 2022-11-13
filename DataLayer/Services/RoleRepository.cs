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
    public class RoleRepository : IRoleRepository
    {
        private SMSEntities db;

        private DbSet<Role> _dbset;
        public RoleRepository(SMSEntities context)
        {
            db = context;

            _dbset = context.Set<Role>();

        }

        public void DeleteRole(Role role)
        {
            if (db.Entry(role).State == EntityState.Detached)
            {
                _dbset.Attach(role);
            }
            _dbset.Remove(role);
        }

        public void DeleteRole(int RoleId)
        {
            var entity = GetRoleById(RoleId);
            DeleteRole(entity);
        }

        public virtual IEnumerable<Role> GetAllRole(Expression<Func<Role, bool>> where = null, Func<IQueryable<Role>, IOrderedQueryable<Role>> orderby = null, string includes = "")
        {
            IQueryable<Role> query = _dbset;

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


        public Role GetRoleById(int RoleId)
        {
            return _dbset.Find(RoleId);
        }

        public void InsertRole(Role role)
        {
            _dbset.Add(role);
        }

        public void Save()
        {
            db.SaveChanges();
        }

        public void UpdateRole(Role role)
        {
            _dbset.Attach(role);
            db.Entry(role).State = EntityState.Modified;
        }


    }
}
