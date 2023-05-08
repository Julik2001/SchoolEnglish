using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace SchoolEnglish.Persistence.EntityTypeConfiguration
{
    public class TaskConfiguration : IEntityTypeConfiguration<Domain.Task>
    {
        public void Configure(EntityTypeBuilder<Domain.Task> builder)
        {
            builder.HasKey(task => task.Id);
            builder.HasIndex(task => task.Id).IsUnique();

            builder.Property(task => task.Header).HasMaxLength(256);
            builder.Property(task => task.Reward);

            builder.HasOne(task => task.Module)
                   .WithMany(module => module.Tasks)
                   .HasForeignKey(task => task.ModuleId)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
