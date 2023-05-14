using MediatR;
using SchoolEnglish.Application.Common.Exceptions;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Users.Commands.UpdateBalance
{
    public class UpdateBalanceHandler : IRequestHandler<UpdateBalanceCommand>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public UpdateBalanceHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task Handle(UpdateBalanceCommand request, CancellationToken cancellationToken)
        {
            var user = _dbContext.Users.FirstOrDefault(user => user.Id == request.UserId);
            if (user == null)
            {
                throw new NotFoundException(nameof(user), request.UserId);
            }

            if (request.ToAdd)
            {
                user.Balance += request.BalanceDifference;
            }
            else if (request.ToRemove)
            { 
                user.Balance -= request.BalanceDifference; 
            }
            await _dbContext.SaveChangesAsync(cancellationToken);
        }
    }
}
