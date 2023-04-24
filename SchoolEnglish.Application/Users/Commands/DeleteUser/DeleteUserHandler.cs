using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Exceptions;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Users.Commands.DeleteUser
{
    public class DeleteUserHandler : IRequestHandler<DeleteUserCommand>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public DeleteUserHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task Handle(DeleteUserCommand request, CancellationToken cancellationToken)
        {

            var user = await _dbContext.Users.FirstOrDefaultAsync(user =>
                user.Id == request.Id, cancellationToken);

            if (user == null)
            {
                throw new NotFoundException(nameof(user), request.Id);
            }

            _dbContext.Users.Remove(user);
            await _dbContext.SaveChangesAsync(cancellationToken);
        }
    }
}
