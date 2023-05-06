using MediatR;

namespace SchoolEnglish.Application.Users.Commands.CreateOrUpdateUser
{
    public class UpdateUserCommand : IRequest<Guid>
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public Guid RoleId { get; set; }
    }
}
