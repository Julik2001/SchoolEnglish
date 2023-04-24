using AutoMapper;
using AutoMapper.QueryableExtensions;
using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Modules.Queries.GetModules
{
    public class GetModulesHandler : IRequestHandler<GetModulesQuery, ModulesVm>
    {
        private readonly ISchoolEnglishDbContext _dbContext;
        private readonly IMapper _mapper;

        public GetModulesHandler(ISchoolEnglishDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<ModulesVm> Handle(GetModulesQuery request, CancellationToken cancellationToken)
        {
            var modules = await _dbContext.Modules.Where(module => module.ParentId == null || module.ParentId == Guid.Empty)
                .ProjectTo<ModuleDto>(_mapper.ConfigurationProvider)
                .ToListAsync(cancellationToken);

            return new ModulesVm { Modules = modules };
        }
    }
}
