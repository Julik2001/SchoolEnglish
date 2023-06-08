using MediatR;

namespace SchoolEnglish.Application.Users.Queries.GetStudents
{
    public class GetStudentsQuery : IRequest<StudentsVm>
    {
        public string TeacherCode { get; set; }
    }
}
