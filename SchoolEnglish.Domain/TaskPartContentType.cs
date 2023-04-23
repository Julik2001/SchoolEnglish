namespace SchoolEnglish.Domain
{
    public class TaskPartContentType
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public IEnumerable<TaskPartContent> TaskPartContentList { get; set; }
    }
}
