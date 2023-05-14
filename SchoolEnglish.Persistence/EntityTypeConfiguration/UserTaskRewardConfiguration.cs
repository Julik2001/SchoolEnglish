using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Persistence.EntityTypeConfiguration
{
    public class UserTaskRewardConfiguration : IEntityTypeConfiguration<UserTaskReward>
    {
        public void Configure(EntityTypeBuilder<UserTaskReward> builder)
        {
            builder.HasKey(reward => reward.Id);
            builder.HasIndex(reward => reward.Id).IsUnique();

            builder.HasOne(reward => reward.User)
                   .WithMany(user => user.TaskRewards)
                   .HasForeignKey(reward => reward.UserId)
                   .OnDelete(DeleteBehavior.Cascade);

            builder.HasOne(reward => reward.Task)
                   .WithMany(task => task.Rewards)
                   .HasForeignKey(reward => reward.TaskId)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
