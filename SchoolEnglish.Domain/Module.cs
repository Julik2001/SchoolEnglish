namespace SchoolEnglish.Domain
{
    public class Module
    {
        public Guid Id { get; set; }
        public string? Number { get; set; }
        public string Name { get; set; }
        public Guid? ParentId { get; set; }
        public Module? Parent { get; set; }
        public IEnumerable<Module> Childs { get; set; }
        public IEnumerable<Task> Tasks { get; set; }
    }
}
