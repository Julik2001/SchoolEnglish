using MediatR;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Users.Commands.GenerateUserTeacherCode
{
    public class GenerateUserTeacherCodeCommand : IRequest
    {
        public User User { get; set; }
    }
}
