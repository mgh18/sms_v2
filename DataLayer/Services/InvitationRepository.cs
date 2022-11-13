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
    public class InvitationRepository : IInvitationRepository
    {
        private SMSEntities db;

        private DbSet<Invitation> _dbset;
        public InvitationRepository(SMSEntities context)
        {
            db = context;

            _dbset = context.Set<Invitation>();

        }

        public void DeleteInvitation(Invitation invitation)
        {
            if (db.Entry(invitation).State == EntityState.Detached)
            {
                _dbset.Attach(invitation);
            }
            _dbset.Remove(invitation);
        }

        public void DeleteInvitation(int InvitationId)
        {
            var entity = GetInvitationById(InvitationId);
            DeleteInvitation(entity);
        }

        public virtual IEnumerable<Invitation> GetAllInvitation(Expression<Func<Invitation, bool>> where = null, Func<IQueryable<Invitation>, IOrderedQueryable<Invitation>> orderby = null, string includes = "")
        {
            IQueryable<Invitation> query = _dbset;

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


        public Invitation GetInvitationById(int InvitationId)
        {
            return _dbset.Find(InvitationId);
        }

        public void InsertInvitation(Invitation invitation)
        {
            _dbset.Add(invitation);
        }

        public void Save()
        {
            db.SaveChanges();
        }

        public void UpdateInvitation(Invitation invitation)
        {
            _dbset.Attach(invitation);
            db.Entry(invitation).State = EntityState.Modified;
        }


    }
}
