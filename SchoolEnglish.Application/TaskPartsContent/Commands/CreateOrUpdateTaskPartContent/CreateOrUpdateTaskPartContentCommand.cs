using MediatR;

namespace SchoolEnglish.Application.TaskPartsContent.Commands.CreateOrUpdateTaskPartContent
{
    public class CreateOrUpdateTaskPartContentCommand : IRequest<Guid>
    {
        public string? Text { get; set; }
        public string? TextToRead { get; set; }
        public string? AnswerVariants { get; set; }
        public string? ImagePath { get; set; }
        public string? AudioPath { get; set; }
        public Guid TypeId { get; set; }
        public Guid TaskPartId { get; set; }
    }
}
