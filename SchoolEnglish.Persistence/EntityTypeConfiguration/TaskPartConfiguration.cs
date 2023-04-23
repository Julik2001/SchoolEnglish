using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Persistence.EntityTypeConfiguration
{
    public  class TaskPartConfiguration : IEntityTypeConfiguration<TaskPart>
    {
        public void Configure(EntityTypeBuilder<TaskPart> builder)
        {
            builder.HasKey(taskPart => taskPart.Id);
            builder.HasIndex(taskPart => taskPart.Id).IsUnique();

            builder.Property(taskPart => taskPart.Number).HasMaxLength(16);
            builder.Property(taskPart => taskPart.RightAnswer).HasMaxLength(4096);
            builder.Property(taskPart => taskPart.ClueText).HasMaxLength(256);
            builder.Property(taskPart => taskPart.ClueCost);

            builder.HasOne(taskPart => taskPart.Task)
                   .WithMany(task => task.Parts)
                   .HasForeignKey(taskPart => taskPart.TaskId);
        }
    }
}
