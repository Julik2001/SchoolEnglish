using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.TaskParts.Commands.CreateOrUpdateTaskPart
{
    public class CreateOrUpdateTaskPartHandler : IRequestHandler<CreateOrUpdateTaskPartCommand, Guid>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public CreateOrUpdateTaskPartHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task<Guid> Handle(CreateOrUpdateTaskPartCommand request, CancellationToken cancellationToken)
        {
            TaskPart? taskPart = null;
            if (request.Id != null && request.Id != Guid.Empty)
            {
                taskPart = await _dbContext.TaskParts.FirstOrDefaultAsync(role =>
                    role.Id == request.Id, cancellationToken);
            }

            if (taskPart == null)
            {
                taskPart = new TaskPart
                {
                    Id = Guid.NewGuid(),
                    Number = request.Number,
                    RightAnswer = request.RightAnswer,
                    ClueText = request.ClueText,
                    ClueCost = request.ClueCost,
                    TaskId = request.TaskId,
                };
                await _dbContext.TaskParts.AddAsync(taskPart, cancellationToken);
            }
            else
            {
                taskPart.Number = request.Number;
                taskPart.RightAnswer = request.RightAnswer;
                taskPart.ClueText = request.ClueText;
                taskPart.ClueCost = request.ClueCost;
                taskPart.TaskId = request.TaskId;
            }

            await _dbContext.SaveChangesAsync(cancellationToken);

            return taskPart.Id;
        }
    }
}
