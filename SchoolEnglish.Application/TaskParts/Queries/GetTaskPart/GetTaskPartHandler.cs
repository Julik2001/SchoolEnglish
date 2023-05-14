using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Exceptions;
using SchoolEnglish.Application.Interfaces;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.TaskParts.Queries.GetTaskPart
{
    public class GetTaskPartHandler : IRequestHandler<GetTaskPartQuery, TaskPart>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public GetTaskPartHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task<TaskPart> Handle(GetTaskPartQuery request, CancellationToken cancellationToken)
        {
            var taskPart = await _dbContext.TaskParts.FirstOrDefaultAsync(taskPart => taskPart.Id == request.TaskPartId);
            if (taskPart == null)
            {
                throw new NotFoundException(nameof(taskPart), request.TaskPartId);
            }
            return taskPart;
        }
    }
}
