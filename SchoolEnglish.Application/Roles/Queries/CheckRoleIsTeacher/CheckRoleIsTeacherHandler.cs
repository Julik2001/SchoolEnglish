using MediatR;
using SchoolEnglish.Application.Common.Helpers;

namespace SchoolEnglish.Application.Roles.Queries.CheckUserIsTeacher
{
    public class CheckRoleIsTeacherHandler : IRequestHandler<CheckRoleIsTeacherQuery, bool>
    {
        public async Task<bool> Handle(CheckRoleIsTeacherQuery request, CancellationToken cancellationToken)
        {
            return request.RoleId == BaseRolesHelper.TeacherRole.Id;
        }
    }
}
