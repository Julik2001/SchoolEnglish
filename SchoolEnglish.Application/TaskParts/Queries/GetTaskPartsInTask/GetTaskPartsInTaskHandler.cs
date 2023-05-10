using AutoMapper;
using AutoMapper.QueryableExtensions;
using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.TaskParts.Queries.GetTaskPartsInTask
{
    public class GetTaskPartsInTaskHandler : IRequestHandler<GetTaskPartsInTaskQuery, TaskPartsVm>
    {
        private readonly ISchoolEnglishDbContext _dbContext;
        private readonly IMapper _mapper;

        public GetTaskPartsInTaskHandler(ISchoolEnglishDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<TaskPartsVm> Handle(GetTaskPartsInTaskQuery request, CancellationToken cancellationToken)
        {
            var parts = await _dbContext.TaskParts.Where(taskPart => taskPart.TaskId == request.TaskId)
                .ProjectTo<TaskPartVm>(_mapper.ConfigurationProvider)
                .ToListAsync(cancellationToken);

            return new TaskPartsVm { Parts = parts };
        }
    }
}
