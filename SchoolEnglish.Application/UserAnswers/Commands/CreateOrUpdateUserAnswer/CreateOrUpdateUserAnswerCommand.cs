using MediatR;

namespace SchoolEnglish.Application.UserAnswers.Commands.CreateOrUpdateUserAnswer
{
    public class CreateOrUpdateUserAnswerCommand : IRequest<Guid>
    {
        public string Answer { get; set; }
        public Guid TaskPartId { get; set; }
        public Guid UserId { get; set; }
    }
}
