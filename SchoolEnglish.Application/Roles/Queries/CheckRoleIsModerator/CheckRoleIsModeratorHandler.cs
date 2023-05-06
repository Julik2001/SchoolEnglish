using MediatR;
using SchoolEnglish.Application.Common.Helpers;

namespace SchoolEnglish.Application.Roles.Queries.CheckUserIsModerator
{
    public class CheckRoleIsModeratorHandler : IRequestHandler<CheckRoleIsModeratorQuery, bool>
    {
        public async Task<bool> Handle(CheckRoleIsModeratorQuery request, CancellationToken cancellationToken)
        {
            return request.RoleId == BaseRolesHelper.ModeratorRole.Id;
        }
    }
}
