using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Persistence.EntityTypeConfiguration
{
    public class ModuleConfiguration : IEntityTypeConfiguration<Module>
    {
        public void Configure(EntityTypeBuilder<Module> builder)
        {
            builder.HasKey(module => module.Id);
            builder.HasIndex(module => module.Id).IsUnique();

            builder.Property(module => module.Name).HasMaxLength(256);
            builder.Property(module => module.Number).HasMaxLength(16);

            builder.HasOne(module => module.Parent)
                   .WithMany(module => module.Childs)
                   .HasForeignKey((Module module) => module.ParentId)
                   .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
