using DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Repositories
{
    public interface IRoleRepository
    {
        IEnumerable<Role> GetAllRole(Expression<Func<Role, bool>> where = null, Func<IQueryable<Role>, IOrderedQueryable<Role>> orderby = null, string includes = "");
        Role GetRoleById(int RoleId);
        void InsertRole(Role role);
        void UpdateRole(Role role);
        void DeleteRole(Role role);
        void DeleteRole(int RoleId);
        void Save();

    }
}
