using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.UserTaskRewards.Queries.CheckUserTaskReward
{
    public class CheckUserTaskRewardHandler : IRequestHandler<CheckUserTaskRewardQuery, bool>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public CheckUserTaskRewardHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task<bool> Handle(CheckUserTaskRewardQuery request, CancellationToken cancellationToken)
        {
            var reward = await _dbContext.UserTaskRewards.FirstOrDefaultAsync(reward =>
                reward.UserId == request.UserId && reward.TaskId == request.TaskId);
            return reward != null;
        }
    }
}
