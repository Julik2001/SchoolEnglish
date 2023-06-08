using MediatR;

namespace SchoolEnglish.Application.Reports.Queries.GetReportForTeacher
{
    public class GetReportForTeacherQuery : IRequest<TeacherReportVm>
    {
        public Guid StudentId { get; set; }
    }
}
