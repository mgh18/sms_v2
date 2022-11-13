using DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Repositories
{
    public interface ITeacherRepository
    {
        IEnumerable<Teacher> GetAllTeacher(Expression<Func<Teacher, bool>> where = null, Func<IQueryable<Teacher>, IOrderedQueryable<Teacher>> orderby = null, string includes = "");
        Teacher GetTeacherById(int TeacherId);
        void InsertTeacher(Teacher teacher);
        void UpdateTeacher(Teacher teacher);
        void DeleteTeacher(Teacher teacher);
        void DeleteTeacher(int TeacherId);
        void Save();

    }
}
