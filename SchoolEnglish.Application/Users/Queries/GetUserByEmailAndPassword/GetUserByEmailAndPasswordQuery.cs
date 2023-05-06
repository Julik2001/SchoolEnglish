using MediatR;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Users.Queries.GetUserByEmailAndPassword
{
    public class GetUserByEmailAndPasswordQuery : IRequest<User>
    {
        public string Email { get; set; }
        public string Password { get; set; }
    }
}
