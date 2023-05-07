using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Roles.Commands.CreateOrUpdateRole
{
    public class CreateOrUpdateRoleHandler : IRequestHandler<CreateOrUpdateRoleCommand, Guid>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public CreateOrUpdateRoleHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task<Guid> Handle(CreateOrUpdateRoleCommand request, CancellationToken cancellationToken)
        {
            Role? role = null;
            if (request.Id != null && request.Id != Guid.Empty)
            {
                role = await _dbContext.Roles.FirstOrDefaultAsync(role =>
                    role.Id == request.Id, cancellationToken);
            }

            if (role == null)
            {
                role = new Role
                {
                    Id = Guid.NewGuid(),
                    Name = request.Name,
                };
                await _dbContext.Roles.AddAsync(role, cancellationToken);
            }
            else
            {
                role.Name = request.Name;
            }

            await _dbContext.SaveChangesAsync(cancellationToken);

            return role.Id;
        }
    }
}
