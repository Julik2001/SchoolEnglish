using MediatR;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Users.Commands.UpdateUserTeacherCode
{
    public class UpdateUserTeacherCodeCommand : IRequest
    {
        public User User { get; set; }
        public string TeacherCode { get; set; }
    }
}
