namespace SchoolEnglish.Persistence
{
    public class DbInitializer
    {
        public static void Initialize(SchoolEnglishDbContext context)
        {
            context.Database.EnsureCreated();
        }
    }
}
