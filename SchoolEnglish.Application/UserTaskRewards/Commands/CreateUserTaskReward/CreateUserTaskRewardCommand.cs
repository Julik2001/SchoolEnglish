using MediatR;

namespace SchoolEnglish.Application.UserTaskRewards.Commands.CreateUserTaskReward
{
    public class CreateUserTaskRewardCommand : IRequest<Guid>
    {
        public Guid UserId { get; set; }
        public Guid TaskId { get; set; }
    }
}
