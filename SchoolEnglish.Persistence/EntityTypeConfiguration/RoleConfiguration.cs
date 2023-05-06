using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SchoolEnglish.Application.Common.Helpers;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Persistence.EntityTypeConfiguration
{
    public class RoleConfiguration : IEntityTypeConfiguration<Role>
    {
        public void Configure(EntityTypeBuilder<Role> builder)
        {
            builder.HasKey(role => role.Id);
            builder.HasIndex(role => role.Id).IsUnique();

            builder.Property(role => role.Name).HasMaxLength(256);

            builder.HasData(BaseRolesHelper.GetBaseRoles());
        }
    }
}
