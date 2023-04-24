using MediatR;

namespace SchoolEnglish.Application.Tasks.Queries.GetTask
{
    public class GetTaskQuery : IRequest<TaskVm>
    {
        public Guid Id { get; set; }
    }
}
