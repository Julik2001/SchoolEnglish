using AutoMapper;
using AutoMapper.QueryableExtensions;
using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Tasks.Queries.GetTasksInModule
{
    public class GetTasksInModuleHandler : IRequestHandler<GetTasksInModuleQuery, ModuleTasksVm>
    {
        private readonly ISchoolEnglishDbContext _dbContext;
        private readonly IMapper _mapper;

        public GetTasksInModuleHandler(ISchoolEnglishDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<ModuleTasksVm> Handle(GetTasksInModuleQuery request, CancellationToken cancellationToken)
        {
            var tasks = await _dbContext.Tasks.Where(task => task.ModuleId == request.ModuleId)
                .ProjectTo<ModuleTaskDto>(_mapper.ConfigurationProvider)
                .ToListAsync(cancellationToken);

            return new ModuleTasksVm { Tasks = tasks };
        }
    }
}
