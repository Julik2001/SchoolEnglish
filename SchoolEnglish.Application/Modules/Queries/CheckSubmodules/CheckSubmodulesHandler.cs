using MediatR;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Modules.Queries.CheckSubmodules
{
    public class CheckSubmodulesHandler : IRequestHandler<CheckSubmodulesQuery, bool>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public CheckSubmodulesHandler(ISchoolEnglishDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<bool> Handle(CheckSubmodulesQuery request, CancellationToken cancellationToken)
        {
            return _dbContext.Modules.Any(module => module.ParentId == request.ModuleId);
        }
    }
}
