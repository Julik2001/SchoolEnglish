using MediatR;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Users.Commands.CreateOrUpdateUser
{
    public class CreateOrUpdateUserCommand : IRequest<Guid>
    {
        public Guid? Id { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public int Balance { get; set; }
        public Guid RoleId { get; set; }
    }
}
