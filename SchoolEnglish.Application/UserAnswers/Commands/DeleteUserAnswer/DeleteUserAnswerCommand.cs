using MediatR;
using System.Diagnostics.Contracts;

namespace SchoolEnglish.Application.UserAnswers.Commands.DeleteUserAnswer
{
    public class DeleteUserAnswerCommand : IRequest
    {
        public Guid Id { get; set; }
    }
}
