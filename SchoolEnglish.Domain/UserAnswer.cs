namespace SchoolEnglish.Domain
{
    public class UserAnswer
    {
        public Guid Id { get; set; }
        public string Answer { get; set; }
        public Guid TaskPartId { get; set; }
        public TaskPart TaskPart { get; set; }
        public Guid UserId { get; set; }
        public User User { get; set; }
    }
}
