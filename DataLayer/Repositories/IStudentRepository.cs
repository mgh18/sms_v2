using DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Repositories
{
    public interface IStudentRepository
    {
        IEnumerable<Student> GetAllStudent(Expression<Func<Student, bool>> where = null, Func<IQueryable<Student>, IOrderedQueryable<Student>> orderby = null, string includes = "");
        Student GetStudentById(int StudentId);
        void InsertStudent(Student student);
        void UpdateStudent(Student student);
        void DeleteStudent(Student student);
        void DeleteStudent(int StudentId);
        void Save();

    }
}
