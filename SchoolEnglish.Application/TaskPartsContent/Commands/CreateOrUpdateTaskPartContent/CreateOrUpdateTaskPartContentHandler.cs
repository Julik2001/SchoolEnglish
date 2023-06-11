using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.TaskPartsContent.Commands.CreateOrUpdateTaskPartContent
{
    public class CreateOrUpdateTaskPartContentHandler : IRequestHandler<CreateOrUpdateTaskPartContentCommand, Guid>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public CreateOrUpdateTaskPartContentHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task<Guid> Handle(CreateOrUpdateTaskPartContentCommand request, CancellationToken cancellationToken)
        {
            TaskPartContent? taskPartContent = null;
            taskPartContent = await _dbContext.TaskPartsContent.FirstOrDefaultAsync(content =>
                    content.TaskPartId == request.TaskPartId, cancellationToken);

            if (taskPartContent == null)
            {
                taskPartContent = new TaskPartContent
                {
                    Id = Guid.NewGuid(),
                    Text = request.Text,
                    TextToRead = request.TextToRead,
                    AnswerVariants = request.AnswerVariants,
                    ImagePath = request.ImagePath,
                    AudioPath = request.AudioPath,
                    TypeId = request.TypeId,
                    TaskPartId = request.TaskPartId,
                };
                await _dbContext.TaskPartsContent.AddAsync(taskPartContent, cancellationToken);
            }
            else
            {
                taskPartContent.Text = request.Text;
                taskPartContent.TextToRead = request.TextToRead;
                taskPartContent.AnswerVariants = request.AnswerVariants;
                taskPartContent.TypeId = request.TypeId;
                taskPartContent.TaskPartId = request.TaskPartId;

                if (!string.IsNullOrEmpty(request.ImagePath))
                {
                    taskPartContent.ImagePath = request.ImagePath;
                }
                if (!string.IsNullOrEmpty(request.AudioPath))
                {
                    taskPartContent.AudioPath = request.AudioPath;
                }
            }

            await _dbContext.SaveChangesAsync(cancellationToken);

            return taskPartContent.Id;
        }
    }
}
