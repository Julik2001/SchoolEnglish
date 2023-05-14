using MediatR;

namespace SchoolEnglish.Application.UserTaskRewards.Queries.CheckUserTaskReward
{
    public class CheckUserTaskRewardQuery : IRequest<bool>
    {
        public Guid UserId { get; set; }
        public Guid TaskId { get; set; }
    }
}
