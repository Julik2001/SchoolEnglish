using MediatR;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Users.Queries.GetUserById
{
    public class GetUserByIdQuery : IRequest<User>
    {
        public Guid UserId { get; set; }
    }
}
