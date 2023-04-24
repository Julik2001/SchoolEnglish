using MediatR;

namespace SchoolEnglish.Application.TaskParts.Commands.DeleteTaskPart
{
    public class DeleteTaskPartCommand : IRequest
    {
        public Guid Id { get; set; }
    }
}
