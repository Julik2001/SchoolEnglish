using MediatR;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Roles.Queries.CheckUserIsModerator
{
    public class CheckRoleIsModeratorQuery : IRequest<bool>
    {
        public Guid RoleId { get; set; }
    }
}
