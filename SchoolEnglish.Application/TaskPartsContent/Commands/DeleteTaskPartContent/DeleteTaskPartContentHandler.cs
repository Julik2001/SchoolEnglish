using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Exceptions;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.TaskPartsContent.Commands.DeleteTaskPartContent
{
    internal class DeleteTaskPartContentHandler : IRequestHandler<DeleteTaskPartContentCommand>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public DeleteTaskPartContentHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task Handle(DeleteTaskPartContentCommand request, CancellationToken cancellationToken)
        {

            var taskPartContent = await _dbContext.TaskPartsContent.FirstOrDefaultAsync(taskPartContent =>
                taskPartContent.Id == request.Id, cancellationToken);

            if (taskPartContent == null)
            {
                throw new NotFoundException(nameof(taskPartContent), request.Id);
            }

            _dbContext.TaskPartsContent.Remove(taskPartContent);
            await _dbContext.SaveChangesAsync(cancellationToken);
        }
    }
}
