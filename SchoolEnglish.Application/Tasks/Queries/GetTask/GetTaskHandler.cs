using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Exceptions;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Tasks.Queries.GetTask
{
    public class GetTaskHandler : IRequestHandler<GetTaskQuery, TaskVm>
    {
        private readonly ISchoolEnglishDbContext _dbContext;
        private readonly IMapper _mapper;

        public GetTaskHandler(ISchoolEnglishDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<TaskVm> Handle(GetTaskQuery request, CancellationToken cancellationToken)
        {
            var task = await _dbContext.Tasks.FirstOrDefaultAsync(task => task.Id == request.Id);

            if (task == null)
            {
                throw new NotFoundException(nameof(task), request.Id);
            }

            return _mapper.Map<TaskVm>(task);
        }
    }
}
