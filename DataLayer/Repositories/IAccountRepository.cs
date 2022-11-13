using DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Repositories
{
    public interface IAccountRepository
    {
        IEnumerable<Account> GetAllAccount(Expression<Func<Account, bool>> where = null, Func<IQueryable<Account>, IOrderedQueryable<Account>> orderby = null, string includes = "");
        Account GetAccountById(int AccountId);
        void InsertAccount(Account account);
        void UpdateAccount(Account account);
        void DeleteAccount(Account account);
        void DeleteAccount(int AccountId);
        void Save();

    }
}
