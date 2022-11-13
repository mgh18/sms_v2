using DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Repositories
{
    public interface IInvitationRepository
    {
        IEnumerable<Invitation> GetAllInvitation(Expression<Func<Invitation, bool>> where = null, Func<IQueryable<Invitation>, IOrderedQueryable<Invitation>> orderby = null, string includes = "");
        Invitation GetInvitationById(int InvitationId);
        void InsertInvitation(Invitation invitation);
        void UpdateInvitation(Invitation invitation);
        void DeleteInvitation(Invitation invitation);
        void DeleteInvitation(int InvitationId);
        void Save();

    }
}
