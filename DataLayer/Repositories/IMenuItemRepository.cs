using DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Repositories
{
    public interface IMenuItemRepository
    {
        IEnumerable<MenuItem> GetAllMenuItem(Expression<Func<MenuItem, bool>> where = null, Func<IQueryable<MenuItem>, IOrderedQueryable<MenuItem>> orderby = null, string includes = "");
        MenuItem GetMenuItemById(int MenuItemId);
        void InsertMenuItem(MenuItem menuItem);
        void UpdateMenuItem(MenuItem menuItem);
        void DeleteMenuItem(MenuItem menuItem);
        void DeleteMenuItem(int MenuItemId);
        void Save();

    }
}
