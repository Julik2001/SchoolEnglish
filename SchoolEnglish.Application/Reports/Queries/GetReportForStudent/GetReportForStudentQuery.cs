using MediatR;

namespace SchoolEnglish.Application.Reports.Queries.GetReportForStudent
{
    public class GetReportForStudentQuery : IRequest<StudentReportVm>
    {
        public Guid TaskId { get; set; }
        public Guid UserId { get; set; }
    }
}
