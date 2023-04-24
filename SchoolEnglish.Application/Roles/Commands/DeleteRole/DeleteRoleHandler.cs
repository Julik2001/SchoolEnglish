using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Exceptions;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Roles.Commands.DeleteRole
{
    public class DeleteRoleHandler : IRequestHandler<DeleteRoleCommand>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public DeleteRoleHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task Handle(DeleteRoleCommand request, CancellationToken cancellationToken)
        {

            var role = await _dbContext.Roles.FirstOrDefaultAsync(role =>
                role.Id == request.Id, cancellationToken);

            if (role == null)
            {
                throw new NotFoundException(nameof(role), request.Id);
            }

            _dbContext.Roles.Remove(role);
            await _dbContext.SaveChangesAsync(cancellationToken);
        }
    }
}
