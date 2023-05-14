using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.UserAnswers.Commands.CreateOrUpdateUserAnswer
{
    public class CreateOrUpdateUserAnswerHandler : IRequestHandler<CreateOrUpdateUserAnswerCommand, Guid>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public CreateOrUpdateUserAnswerHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task<Guid> Handle(CreateOrUpdateUserAnswerCommand request, CancellationToken cancellationToken)
        {
            UserAnswer? answer = null;
            answer = await _dbContext.UserAnswers.FirstOrDefaultAsync(answer =>
                    answer.TaskPartId == request.TaskPartId && answer.UserId == request.UserId, cancellationToken);

            if (answer == null)
            {
                answer = new UserAnswer
                {
                    Id = Guid.NewGuid(),
                    Answer = request.Answer,
                    UserId = request.UserId,
                    TaskPartId = request.TaskPartId,
                };
                await _dbContext.UserAnswers.AddAsync(answer, cancellationToken);
            }
            else
            {
                answer.Answer = request.Answer;
            }

            await _dbContext.SaveChangesAsync(cancellationToken);

            return answer.Id;
        }
    }
}
