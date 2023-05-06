using MediatR;

namespace SchoolEnglish.Application.Users.Queries.AuthenticateUser
{
    public class AuthenticateUserQuery : IRequest<string>
    {
        public Guid UserId { get; set; }
        public Guid RoleId { get; set; }
    }
}
