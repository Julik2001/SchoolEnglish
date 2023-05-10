namespace SchoolEnglish.Domain
{
    public class TaskPartContent
    {
        public Guid Id { get; set; }        
        public string? Text { get; set; }
        public string? TextToRead { get; set; }
        public string? AnswerVariants { get; set; }
        public string? ImagePath { get; set; }
        public string? AudioPath { get; set; }
        public Guid TypeId { get; set; }
        public TaskPartContentType Type { get; set; }
        public Guid TaskPartId { get; set; }
        public TaskPart TaskPart { get; set; }
    }
}
