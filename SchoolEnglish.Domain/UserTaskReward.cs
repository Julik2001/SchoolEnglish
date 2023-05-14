namespace SchoolEnglish.Domain
{
    public class UserTaskReward
    {
        public Guid Id { get; set; }
        public Guid UserId { get; set; }
        public User User { get; set; }
        public Guid TaskId { get; set; }
        public Task Task { get; set; }
    }
}
