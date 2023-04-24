using MediatR;

namespace SchoolEnglish.Application.Tasks.Commands.DeleteTask
{
    public class DeleteTaskCommand : IRequest
    {
        public Guid Id { get; set; }
    }
}
