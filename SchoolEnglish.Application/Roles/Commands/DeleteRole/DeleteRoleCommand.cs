using MediatR;

namespace SchoolEnglish.Application.Roles.Commands.DeleteRole
{
    public class DeleteRoleCommand : IRequest
    {
        public Guid Id { get; set; }
    }
}
