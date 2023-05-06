using AutoMapper;
using MediatR;
using SchoolEnglish.Application.Common.Exceptions;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Modules.Queries.GetModule
{
    public class GetModuleHandler : IRequestHandler<GetModuleQuery, ModuleDto>
    {
        private readonly ISchoolEnglishDbContext _dbContext;
        private readonly IMapper _mapper;

        public GetModuleHandler(ISchoolEnglishDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<ModuleDto> Handle(GetModuleQuery request, CancellationToken cancellationToken)
        {
            var module = _dbContext.Modules.FirstOrDefault(module => module.Id == request.ModuleId);

            if (module == null)
            {
                throw new NotFoundException(nameof(module), request.ModuleId);
            }

            return _mapper.Map<ModuleDto>(module);
        }
    }
}
