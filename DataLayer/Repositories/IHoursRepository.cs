using DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Repositories
{
    public interface IHoursRepository
    {
        IEnumerable<Hours> GetAllHours(Expression<Func<Hours, bool>> where = null, Func<IQueryable<Hours>, IOrderedQueryable<Hours>> orderby = null, string includes = "");
        Hours GetHoursById(int HoursId);
        void InsertHours(Hours hours);
        void UpdateHours(Hours hours);
        void DeleteHours(Hours hours);
        void DeleteHours(int HoursId);
        void Save();

    }
}
