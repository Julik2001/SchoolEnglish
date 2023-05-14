namespace SchoolEnglish.Domain
{
    public class Task
    {
        public Guid Id { get; set; }
        public string Header { get; set; }
        public int TimeInMinutes { get; set; }
        public int Reward { get; set; }
        public Guid ModuleId { get; set; }
        public Module Module { get; set; }
        public IEnumerable<TaskPart> Parts { get; set; }
        public IEnumerable<UserTaskReward> Rewards { get; set; }
    }
}
