using DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Repositories
{
    public interface ICourseRepository
    {
        IEnumerable<Course> Get(Expression<Func<Course, bool>> where = null, Func<IQueryable<Course>, IOrderedQueryable<Course>> orderby = null, string includes = "");
       
        Course GetCourseById(int CourseId);
        void InsertCourse(Course course);
        void UpdateCourse(Course course);
        void DeleteCourse(Course course);
        void DeleteCourse(int CourseId);
        void Save();

    }
}
