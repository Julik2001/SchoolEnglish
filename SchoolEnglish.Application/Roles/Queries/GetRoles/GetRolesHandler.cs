using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Roles.Queries.GetRoles
{
    internal class GetRolesHandler : IRequestHandler<GetRolesQuery, RolesVm>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public GetRolesHandler(ISchoolEnglishDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<RolesVm> Handle(GetRolesQuery request, CancellationToken cancellationToken)
        {
            var roles = await _dbContext.Roles.ToListAsync(cancellationToken);

            return new RolesVm { Roles = roles };
        }
    }
}
