using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Persistence.EntityTypeConfiguration
{
    public class UserConfiguration : IEntityTypeConfiguration<User>
    {
        public void Configure(EntityTypeBuilder<User> builder)
        {
            builder.HasKey(user => user.Id);
            builder.HasIndex(user => user.Id).IsUnique();

            builder.Property(user => user.Name).HasMaxLength(256);
            builder.Property(user => user.Surname).HasMaxLength(256);
            builder.HasIndex(user => user.Email).IsUnique();
            builder.Property(user => user.Email).HasMaxLength(256);
            builder.Property(user => user.Password).HasMaxLength(256);
            builder.Property(user => user.Balance);
            builder.Property(user => user.TeacherCode).IsRequired(false);

            builder.HasOne(user => user.Role)
                   .WithMany(role => role.Users)
                   .HasForeignKey(user => user.RoleId);
        }
    }
}
