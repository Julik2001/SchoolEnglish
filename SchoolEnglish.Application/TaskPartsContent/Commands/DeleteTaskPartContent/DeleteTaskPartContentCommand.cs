using MediatR;

namespace SchoolEnglish.Application.TaskPartsContent.Commands.DeleteTaskPartContent
{
    public class DeleteTaskPartContentCommand : IRequest
    {
        public Guid Id { get; set; }
    }
}
