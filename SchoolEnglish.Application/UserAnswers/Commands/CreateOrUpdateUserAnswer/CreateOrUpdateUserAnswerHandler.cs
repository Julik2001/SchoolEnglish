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
            if (request.Id != null && request.Id != Guid.Empty)
            {
                answer = await _dbContext.UserAnswers.FirstOrDefaultAsync(role =>
                    role.Id == request.Id, cancellationToken);
            }

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
                answer.UserId = request.UserId;
                answer.TaskPartId = request.TaskPartId;
            }

            await _dbContext.SaveChangesAsync(cancellationToken);

            return answer.Id;
        }
    }
}
