using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Interfaces
{
    public interface ISchoolEnglishDbContext
    {
        DbSet<Module> Modules { get; set; }
        DbSet<Role> Roles { get; set; }
        DbSet<Domain.Task> Tasks { get; set; }
        DbSet<TaskPart> TaskParts { get; set; }
        DbSet<TaskPartContent> TaskPartsContent { get; set; }
        DbSet<TaskPartContentType> TaskPartsContentTypes { get; set; }
        DbSet<UserAnswer> UserAnswers { get; set; }
        DbSet<User> Users { get; set; }
        DbSet<UserTaskReward> UserTaskRewards { get; set; }
        Task<int> SaveChangesAsync(CancellationToken cancellationToken);
    }
}
