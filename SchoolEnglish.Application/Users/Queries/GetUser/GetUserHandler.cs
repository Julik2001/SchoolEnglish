using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Exceptions;
using SchoolEnglish.Application.Common.Helpers;
using SchoolEnglish.Application.Interfaces;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Users.Queries.GetUser
{
    public class GetUserHandler : IRequestHandler<GetUserQuery, User>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public GetUserHandler(ISchoolEnglishDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<User> Handle(GetUserQuery request, CancellationToken cancellationToken)
        {
            var passwordHash = HashPasswordHelper.HashPassword(request.Password);

            var user = await _dbContext.Users.FirstOrDefaultAsync(user =>
                user.Email == request.Email && user.Password == passwordHash);

            if (user == null)
            {
                throw new NotFoundException(nameof(user), $"{request.Email};{request.Password}");
            }

            return user;
        }
    }
}
