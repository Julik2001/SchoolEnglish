using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Helpers;
using SchoolEnglish.Application.Interfaces;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Users.Commands.CreateOrUpdateUser
{
    public class CreateOrUpdateUserHandler : IRequestHandler<CreateOrUpdateUserCommand, Guid>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public CreateOrUpdateUserHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task<Guid> Handle(CreateOrUpdateUserCommand request, CancellationToken cancellationToken)
        {
            User? user = null;
            if (request.Id != null && request.Id != Guid.Empty)
            {
                user = await _dbContext.Users.FirstOrDefaultAsync(user =>
                    user.Id == request.Id, cancellationToken);
            }

            if (user == null)
            {
                user = new User
                {
                    Id = Guid.NewGuid(),
                    Name = request.Surname,
                    Surname = request.Surname,
                    Email = request.Email,
                    Password = HashPasswordHelper.HashPassword(request.Password),
                    Balance = request.Balance,
                    RoleId = request.RoleId,
                };
                await _dbContext.Users.AddAsync(user, cancellationToken);
            }
            else
            {
                user.Name = request.Surname;
                user.Surname = request.Surname;
                user.Email = request.Email;
                user.Password = request.Password;
                user.Balance = request.Balance;
                user.RoleId = request.RoleId;
            }

            await _dbContext.SaveChangesAsync(cancellationToken);

            return user.Id;
        }
    }
}
