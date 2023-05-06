using MediatR;
using SchoolEnglish.Application.Common.Helpers;

namespace SchoolEnglish.Application.Roles.Queries.CheckUserIsStudent
{
    public class CheckRoleIsStudentHandler : IRequestHandler<CheckRoleIsStudentQuery, bool>
    {
        public async Task<bool> Handle(CheckRoleIsStudentQuery request, CancellationToken cancellationToken)
        {
            return request.RoleId == BaseRolesHelper.StudentRole.Id;
        }
    }
}
