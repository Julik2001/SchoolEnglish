using MediatR;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.TaskParts.Queries.GetTaskPart
{
    public class GetTaskPartQuery : IRequest<TaskPart>
    {
        public Guid TaskPartId { get; set; }
    }
}
