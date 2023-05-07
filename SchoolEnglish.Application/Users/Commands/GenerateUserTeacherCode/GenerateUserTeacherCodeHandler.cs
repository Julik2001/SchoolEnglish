using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Helpers;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Users.Commands.GenerateUserTeacherCode
{
    public class GenerateUserTeacherCodeHandler : IRequestHandler<GenerateUserTeacherCodeCommand>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public GenerateUserTeacherCodeHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task Handle(GenerateUserTeacherCodeCommand request, CancellationToken cancellationToken)
        {
            var codes = await _dbContext.Users.Where(user => user.RoleId == BaseRolesHelper.TeacherRole.Id && user.TeacherCode != null)
                .Select(user => user.TeacherCode).ToListAsync();

            var lastCode = 1;
            if (codes.Count > 0)
            {
                lastCode = codes.Max(code => int.Parse(code));
                lastCode++;
            }

            var teacherCode = lastCode.ToString();
            while (teacherCode.Length < 4)
            {
                teacherCode = $"0{teacherCode}";
            }

            request.User.TeacherCode = teacherCode;

            await _dbContext.SaveChangesAsync(cancellationToken);
        }
    }
}
