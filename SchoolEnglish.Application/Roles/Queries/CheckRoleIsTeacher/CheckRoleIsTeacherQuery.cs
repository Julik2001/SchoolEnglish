using MediatR;

namespace SchoolEnglish.Application.Roles.Queries.CheckUserIsTeacher
{
    public class CheckRoleIsTeacherQuery : IRequest<bool>
    {
        public Guid RoleId { get; set; }
    }
}
