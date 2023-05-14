using MediatR;

namespace SchoolEnglish.Application.Users.Commands.UpdateBalance
{
    public class UpdateBalanceCommand : IRequest
    {
        public Guid UserId { get; set; }
        public int BalanceDifference { get; set; }
        public bool ToAdd { get; set; } = true;
        public bool ToRemove { get; set; } = false;
    }
}
