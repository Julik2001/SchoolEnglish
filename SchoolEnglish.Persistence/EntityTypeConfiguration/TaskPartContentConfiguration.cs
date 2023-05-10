using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Persistence.EntityTypeConfiguration
{
    public class TaskPartContentConfiguration : IEntityTypeConfiguration<TaskPartContent>
    {
        public void Configure(EntityTypeBuilder<TaskPartContent> builder)
        {
            builder.HasKey(taskPartContent => taskPartContent.Id);
            builder.HasIndex(taskPartContent => taskPartContent.Id).IsUnique();

            builder.Property(taskPartContent => taskPartContent.Text).HasMaxLength(4096);
            builder.Property(taskPartContent => taskPartContent.TextToRead).HasMaxLength(8192);
            builder.Property(taskPartContent => taskPartContent.AnswerVariants).HasMaxLength(2048);
            builder.Property(taskPartContent => taskPartContent.ImagePath).HasMaxLength(256);
            builder.Property(taskPartContent => taskPartContent.AudioPath).HasMaxLength(256);

            builder.HasOne(taskPartContent => taskPartContent.Type)
                   .WithMany(taskPartContentType => taskPartContentType.TaskPartContentList)
                   .HasForeignKey(taskPartContent => taskPartContent.TypeId)
                   .OnDelete(DeleteBehavior.Cascade);
            builder.HasOne(taskPartContent => taskPartContent.TaskPart)
                   .WithOne(taskPart => taskPart.Content)
                   .HasForeignKey((TaskPartContent taskPartContent) => taskPartContent.TaskPartId)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
