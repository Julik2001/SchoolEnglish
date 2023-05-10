using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Exceptions;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.TaskParts.Queries.GetTaskPartWithContent
{
    public class GetTaskPartWithContentHandler : IRequestHandler<GetTaskPartWithContentQuery, TaskPartVm>
    {
        private readonly ISchoolEnglishDbContext _dbContext;
        private readonly IMapper _mapper;

        public GetTaskPartWithContentHandler(ISchoolEnglishDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<TaskPartVm> Handle(GetTaskPartWithContentQuery request, CancellationToken cancellationToken)
        {
            var taskPart = await _dbContext.TaskParts.FirstOrDefaultAsync(taskPart => taskPart.Id == request.Id, cancellationToken);
            if (taskPart == null)
            {
                throw new NotFoundException(nameof(taskPart), request.Id);
            }

            var taskPartContent = await _dbContext.TaskPartsContent.FirstOrDefaultAsync(content => content.TaskPartId == request.Id, cancellationToken);
            if (taskPartContent == null)
            {
                throw new NotFoundException(nameof(taskPartContent), request.Id);
            }

            taskPart.Content = taskPartContent;

            return _mapper.Map<TaskPartVm>(taskPart);
        }
    }
}
