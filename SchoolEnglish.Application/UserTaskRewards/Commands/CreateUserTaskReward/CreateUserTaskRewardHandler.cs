using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.UserTaskRewards.Commands.CreateUserTaskReward
{
    public class CreateUserTaskRewardHandler : IRequestHandler<CreateUserTaskRewardCommand, Guid>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public CreateUserTaskRewardHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task<Guid> Handle(CreateUserTaskRewardCommand request, CancellationToken cancellationToken)
        {
            UserTaskReward? reward;
            reward = await _dbContext.UserTaskRewards.FirstOrDefaultAsync(reward =>
                reward.UserId == request.UserId && reward.TaskId == request.TaskId, cancellationToken);

            if (reward == null)
            {
                reward = new UserTaskReward
                {
                    Id = Guid.NewGuid(),
                    UserId = request.UserId,
                    TaskId = request.TaskId,
                };
                await _dbContext.UserTaskRewards.AddAsync(reward, cancellationToken);
                await _dbContext.SaveChangesAsync(cancellationToken);
            }
            
            return reward.Id;
        }
    }
}
