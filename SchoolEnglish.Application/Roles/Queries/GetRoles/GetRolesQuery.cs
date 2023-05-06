using MediatR;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Roles.Queries.GetRoles
{
    public class GetRolesQuery : IRequest<RolesVm>
    {
    }
}
