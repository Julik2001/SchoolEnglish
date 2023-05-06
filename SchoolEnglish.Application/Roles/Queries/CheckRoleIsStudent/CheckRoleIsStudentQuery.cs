using MediatR;

namespace SchoolEnglish.Application.Roles.Queries.CheckUserIsStudent
{
    public class CheckRoleIsStudentQuery : IRequest<bool>
    {
        public Guid RoleId { get; set; }
    }
}
