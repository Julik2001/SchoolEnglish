using MediatR;

namespace SchoolEnglish.Application.TaskParts.Commands.CreateOrUpdateTaskPart
{
    public class CreateOrUpdateTaskPartCommand : IRequest<Guid>
    {
        public Guid? Id { get; set; }
        public string Number { get; set; }
        public string RightAnswer { get; set; }
        public string ClueText { get; set; }
        public int ClueCost { get; set; }
        public Guid TaskId { get; set; }
    }
}
