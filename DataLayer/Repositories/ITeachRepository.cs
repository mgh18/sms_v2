using DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Repositories
{
    public interface ITeachRepository
    {
        IEnumerable<Teach> Get(Expression<Func<Teach, bool>> where = null, Func<IQueryable<Teach>, IOrderedQueryable<Teach>> orderby = null, string includes = "");
        Teach GetTeachById(int TeachId);
        void InsertTeach(Teach teach);
        void UpdateTeach(Teach teach);
        void DeleteTeach(Teach teach);
        void DeleteTeach(int TeachId);
        void Save();

    }
}
