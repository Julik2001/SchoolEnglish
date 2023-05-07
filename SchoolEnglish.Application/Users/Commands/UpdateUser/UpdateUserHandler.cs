using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Exceptions;
using SchoolEnglish.Application.Interfaces;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Users.Commands.CreateOrUpdateUser
{
    public class UpdateUserHandler : IRequestHandler<UpdateUserCommand, Guid>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public UpdateUserHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task<Guid> Handle(UpdateUserCommand request, CancellationToken cancellationToken)
        {
            User? user = null;
            if (request.Id != null && request.Id != Guid.Empty)
            {
                user = await _dbContext.Users.FirstOrDefaultAsync(user =>
                    user.Id == request.Id, cancellationToken);
            }

            if (user == null)
            {
                throw new NotFoundException(nameof(user), request.Id);
            }

            user.Name = request.Name;
            user.Surname = request.Surname;
            user.RoleId = request.RoleId;

            await _dbContext.SaveChangesAsync(cancellationToken);

            return user.Id;
        }
    }
}
