using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Exceptions;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.TaskParts.Commands.DeleteTaskPart
{
    public class DeleteTaskPartHandler : IRequestHandler<DeleteTaskPartCommand>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public DeleteTaskPartHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task Handle(DeleteTaskPartCommand request, CancellationToken cancellationToken)
        {

            var taskPart = await _dbContext.TaskParts.FirstOrDefaultAsync(taskPart =>
                taskPart.Id == request.Id, cancellationToken);

            if (taskPart == null)
            {
                throw new NotFoundException(nameof(taskPart), request.Id);
            }

            _dbContext.TaskParts.Remove(taskPart);
            await _dbContext.SaveChangesAsync(cancellationToken);
        }
    }
}
