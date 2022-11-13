using DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Repositories
{
    public interface INameOfCourseRepository
    {
        IEnumerable<NameOfCourse> GetAllNameOfCourse(Expression<Func<NameOfCourse, bool>> where = null, Func<IQueryable<NameOfCourse>, IOrderedQueryable<NameOfCourse>> orderby = null, string includes = "");
        NameOfCourse GetNameOfCourseById(int NameOfCourseId);
        void InsertNameOfCourse(NameOfCourse nameOfCourse);
        void UpdateNameOfCourse(NameOfCourse nameOfCourse);
        void DeleteNameOfCourse(NameOfCourse nameOfCourse);
        void DeleteNameOfCourse(int NameOfCourseId);
        void Save();

    }
}
