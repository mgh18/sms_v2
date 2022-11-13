using DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Repositories
{
    public interface IWeekdaysRepository
    {
        IEnumerable<Weekdays> GetAllWeekdays(Expression<Func<Weekdays, bool>> where = null, Func<IQueryable<Weekdays>, IOrderedQueryable<Weekdays>> orderby = null, string includes = "");
        Weekdays GetWeekdaysById(int WeekdaysId);
        void InsertWeekdays(Weekdays weekdays);
        void UpdateWeekdays(Weekdays weekdays);
        void DeleteWeekdays(Weekdays weekdays);
        void DeleteWeekdays(int WeekdaysId);
        void Save();

    }
}
