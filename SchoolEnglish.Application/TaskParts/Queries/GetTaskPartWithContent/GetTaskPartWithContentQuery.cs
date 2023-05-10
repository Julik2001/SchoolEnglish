using MediatR;

namespace SchoolEnglish.Application.TaskParts.Queries.GetTaskPartWithContent
{
    public class GetTaskPartWithContentQuery : IRequest<TaskPartVm>
    {
        public Guid Id { get; set; }
    }
}
