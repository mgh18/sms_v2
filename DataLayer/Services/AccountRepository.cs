using DataLayer.Models;
using DataLayer.Repositories;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using System.Runtime.Remoting.Contexts;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Services
{
    public class AccountRepository : IAccountRepository
    {
        private SMSEntities db;

        private DbSet<Account> _dbset;
        public AccountRepository(SMSEntities context)
        {
            db = context;

            _dbset = context.Set<Account>();

        }
        
        public void DeleteAccount(Account account)
        {
            if (db.Entry(account).State == EntityState.Detached)
            {
                _dbset.Attach(account);
            }
            _dbset.Remove(account);
        }

        public void DeleteAccount(int AccountId)
        {
            var entity = GetAccountById(AccountId);
            DeleteAccount(entity);
        }

        public virtual IEnumerable<Account> GetAllAccount(Expression<Func<Account, bool>> where = null, Func<IQueryable<Account>, IOrderedQueryable<Account>> orderby = null, string includes = "")
        {
            IQueryable<Account> query = _dbset;

            if (where != null)
            {
                query = query.Where(where);
            }
            if (orderby != null)
            {
                query = orderby(query);
            }
            if (includes != "")
            {
                foreach (string include in includes.Split(','))
                {
                    query = query.Include(include);
                }
            }


            return query.ToList();

        }


        public Account GetAccountById(int AccountId)
        {
            return _dbset.Find(AccountId);
        }

        public void InsertAccount(Account account)
        {
            _dbset.Add(account);
        }

        public void Save()
        {
            db.SaveChanges();
        }

        public void UpdateAccount(Account account)
        {
            _dbset.Attach(account);
            db.Entry(account).State = EntityState.Modified;
        }

       
    }
}
