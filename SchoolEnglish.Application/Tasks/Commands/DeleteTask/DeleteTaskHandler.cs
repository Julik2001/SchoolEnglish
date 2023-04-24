using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Exceptions;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Tasks.Commands.DeleteTask
{
    public class DeleteTaskHandler : IRequestHandler<DeleteTaskCommand>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public DeleteTaskHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task Handle(DeleteTaskCommand request, CancellationToken cancellationToken)
        {

            var task = await _dbContext.Tasks.FirstOrDefaultAsync(task =>
                task.Id == request.Id, cancellationToken);

            if (task == null)
            {
                throw new NotFoundException(nameof(task), request.Id);
            }

            _dbContext.Tasks.Remove(task);
            await _dbContext.SaveChangesAsync(cancellationToken);
        }
    }
}
