using AutoMapper;
using AutoMapper.QueryableExtensions;
using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Modules.Queries.GetSubmodules
{
    public class GetSubmodulesHandler : IRequestHandler<GetSubmodulesQuery, SubmodulesVm>
    {
        private readonly ISchoolEnglishDbContext _dbContext;
        private readonly IMapper _mapper;

        public GetSubmodulesHandler(ISchoolEnglishDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<SubmodulesVm> Handle(GetSubmodulesQuery request, CancellationToken cancellationToken)
        {
            var submodules = await _dbContext.Modules.Where(module => module.ParentId == request.ParentId)
                .ProjectTo<ModuleDto>(_mapper.ConfigurationProvider)
                .ToListAsync(cancellationToken);

            return new SubmodulesVm { Modules = submodules };
        }
    }
}
