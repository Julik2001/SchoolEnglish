using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Common.Helpers
{
    public static class BaseRolesHelper
    {
        public static Role TeacherRole { get; } = new Role { Id = Guid.Parse("70813A19-C705-40B9-A5E8-543986263BF5"), Name = "Учитель" };
        public static Role StudentRole { get; } = new Role { Id = Guid.Parse("28FEC602-A09F-47CC-876D-6EE1D803F350"), Name = "Ученик" };
        public static Role ModeratorRole { get; } = new Role { Id = Guid.Parse("B4D93474-01AF-4E27-9705-64098CB286AE"), Name = "Модератор" };

        public static IEnumerable<Role> GetBaseRoles()
        {
            return new List<Role> { TeacherRole, StudentRole, ModeratorRole };
        }
    }
}
