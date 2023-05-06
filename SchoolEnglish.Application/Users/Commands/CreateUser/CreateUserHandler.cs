using MediatR;
using SchoolEnglish.Application.Common.Helpers;
using SchoolEnglish.Application.Interfaces;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Users.Commands.CreateUser
{
    public class CreateUserHandler : IRequestHandler<CreateUserCommand, Guid>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public CreateUserHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task<Guid> Handle(CreateUserCommand request, CancellationToken cancellationToken)
        {
            var user = new User
            {
                Id = Guid.NewGuid(),
                Name = request.Name,
                Surname = request.Surname,
                Email = request.Email,
                Password = HashPasswordHelper.HashPassword(request.Password),
                Balance = 0,
                RoleId = request.RoleId,
            };

            await _dbContext.Users.AddAsync(user, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return user.Id;
        }
    }
}
