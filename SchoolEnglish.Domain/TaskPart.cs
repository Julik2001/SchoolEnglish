namespace SchoolEnglish.Domain
{
    public class TaskPart
    {
        public Guid Id { get; set; }
        public string Number { get; set; }
        public string RightAnswer { get; set; }
        public string ClueText { get; set; }
        public int ClueCost { get; set; }
        public Guid TaskId { get; set; }
        public Task Task { get; set; }
        public TaskPartContent Content { get; set; }
        public IEnumerable<UserAnswer> Answers { get; set; }
    }
}
