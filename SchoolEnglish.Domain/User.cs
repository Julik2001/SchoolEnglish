namespace SchoolEnglish.Domain
{
    public class User
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public int Balance { get; set; }
        public string TeacherCode { get; set; }
        public Guid RoleId { get; set; }
        public Role Role { get; set; }
        public IEnumerable<UserAnswer> Answers { get; set; }
    }
}
