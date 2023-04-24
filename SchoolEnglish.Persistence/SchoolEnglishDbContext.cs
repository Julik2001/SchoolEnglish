using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;
using SchoolEnglish.Domain;
using SchoolEnglish.Persistence.EntityTypeConfiguration;

namespace SchoolEnglish.Persistence
{
    public class SchoolEnglishDbContext : DbContext, ISchoolEnglishDbContext
    {
        public DbSet<Module> Modules { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<Domain.Task> Tasks { get; set; }
        public DbSet<TaskPart> TaskParts { get; set; }
        public DbSet<TaskPartContent> TaskPartsContent { get; set; }
        public DbSet<TaskPartContentType> TaskPartsContentTypes { get; set; }
        public DbSet<UserAnswer> UserAnswers { get; set; }
        public DbSet<User> Users { get; set; }

        public SchoolEnglishDbContext(DbContextOptions<SchoolEnglishDbContext> options)
            : base(options) { }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.ApplyConfiguration(new ModuleConfiguration());
            builder.ApplyConfiguration(new RoleConfiguration());
            builder.ApplyConfiguration(new TaskConfiguration());
            builder.ApplyConfiguration(new TaskPartConfiguration());
            builder.ApplyConfiguration(new TaskPartContentConfiguration());
            builder.ApplyConfiguration(new TaskPartContentTypeConfiguration());
            builder.ApplyConfiguration(new UserAnswerConfiguration());
            builder.ApplyConfiguration(new UserConfiguration());
            base.OnModelCreating(builder);
        }
    }
}
