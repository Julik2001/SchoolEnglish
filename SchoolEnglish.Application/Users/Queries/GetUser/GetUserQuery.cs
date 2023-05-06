using MediatR;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Users.Queries.GetUser
{
    public class GetUserQuery : IRequest<User>
    {
        public string Email { get; set; }
        public string Password { get; set; }
    }
}
