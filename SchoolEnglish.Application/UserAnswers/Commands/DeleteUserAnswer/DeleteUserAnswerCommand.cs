using MediatR;

namespace SchoolEnglish.Application.UserAnswers.Commands.DeleteUserAnswer
{
    public class DeleteUserAnswerCommand : IRequest
    {
        public Guid Id { get; set; }
    }
}
