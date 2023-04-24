using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Exceptions;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.UserAnswers.Commands.DeleteUserAnswer
{
    public class DeleteUserAnswerHandler : IRequestHandler<DeleteUserAnswerCommand>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public DeleteUserAnswerHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task Handle(DeleteUserAnswerCommand request, CancellationToken cancellationToken)
        {

            var answer = await _dbContext.UserAnswers.FirstOrDefaultAsync(answer =>
                answer.Id == request.Id, cancellationToken);

            if (answer == null)
            {
                throw new NotFoundException(nameof(answer), request.Id);
            }

            _dbContext.UserAnswers.Remove(answer);
            await _dbContext.SaveChangesAsync(cancellationToken);
        }
    }
}
