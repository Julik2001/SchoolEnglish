using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Persistence.EntityTypeConfiguration
{
    public class TaskPartContentTypeConfiguration : IEntityTypeConfiguration<TaskPartContentType>
    {
        public void Configure(EntityTypeBuilder<TaskPartContentType> builder)
        {
            builder.HasKey(taskPartContentType => taskPartContentType.Id);
            builder.HasIndex(taskPartContentType => taskPartContentType.Id).IsUnique();

            builder.Property(taskPartContentType => taskPartContentType.Name).HasMaxLength(256);
        }
    }
}
