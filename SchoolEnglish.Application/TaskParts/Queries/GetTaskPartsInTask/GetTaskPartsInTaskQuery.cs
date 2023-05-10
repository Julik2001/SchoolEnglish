using MediatR;

namespace SchoolEnglish.Application.TaskParts.Queries.GetTaskPartsInTask
{
    public class GetTaskPartsInTaskQuery : IRequest<TaskPartsVm>
    {
        public Guid TaskId { get; set; }
    }
}
