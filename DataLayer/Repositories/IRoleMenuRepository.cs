using DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Repositories
{
    public interface IRoleMenuRepository
    {
        IEnumerable<RoleMenu> GetAllRoleMenu(Expression<Func<RoleMenu, bool>> where = null, Func<IQueryable<RoleMenu>, IOrderedQueryable<RoleMenu>> orderby = null, string includes = "");
        RoleMenu GetRoleMenuById(int RoleMenuId);
        void InsertRoleMenu(RoleMenu roleMenu);
        void UpdateRoleMenu(RoleMenu roleMenu);
        void DeleteRoleMenu(RoleMenu roleMenu);
        void DeleteRoleMenu(int RoleMenuId);
        void Save();

    }
}
