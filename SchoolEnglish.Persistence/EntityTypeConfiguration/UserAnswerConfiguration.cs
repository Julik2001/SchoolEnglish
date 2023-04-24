using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Persistence.EntityTypeConfiguration
{
    public class UserAnswerConfiguration : IEntityTypeConfiguration<UserAnswer>
    {
        public void Configure(EntityTypeBuilder<UserAnswer> builder)
        {
            builder.HasKey(userAnswer => userAnswer.Id);
            builder.HasIndex(userAnswer => userAnswer.Id).IsUnique();

            builder.Property(userAnswer => userAnswer.Answer).HasMaxLength(4096);

            builder.HasOne(userAnswer => userAnswer.TaskPart)
                   .WithMany(taskPart => taskPart.Answers)
                   .HasForeignKey(userAnswer => userAnswer.TaskPartId);
            builder.HasOne(userAnswer => userAnswer.User)
                   .WithMany(user => user.Answers)
                   .HasForeignKey(userAnswer => userAnswer.UserId);
        }
    }
}
