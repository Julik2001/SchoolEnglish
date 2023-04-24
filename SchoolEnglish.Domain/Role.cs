namespace SchoolEnglish.Domain
{
    public class Role
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public IEnumerable<User> Users { get; set; }
    }
}
