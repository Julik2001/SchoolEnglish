using MediatR;

namespace SchoolEnglish.Application.Roles.Commands.CreateOrUpdateRole
{
    public class CreateOrUpdateRoleCommand : IRequest<Guid>
    {
        public Guid? Id { get; set; }
        public string Name { get; set; }
    }
}
