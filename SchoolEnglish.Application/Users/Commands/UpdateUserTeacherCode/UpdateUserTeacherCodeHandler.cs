using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Exceptions;
using SchoolEnglish.Application.Common.Helpers;
using SchoolEnglish.Application.Interfaces;


namespace SchoolEnglish.Application.Users.Commands.UpdateUserTeacherCode
{
    public class UpdateUserTeacherCodeHandler : IRequestHandler<UpdateUserTeacherCodeCommand>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public UpdateUserTeacherCodeHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task Handle(UpdateUserTeacherCodeCommand request, CancellationToken cancellationToken)
        {
            var teacherCodeExist = await _dbContext.Users.Where(user => user.RoleId == BaseRolesHelper.TeacherRole.Id)
                .AnyAsync(user => user.TeacherCode == request.TeacherCode);

            if (!teacherCodeExist)
            {
                throw new NotFoundException(nameof(request.TeacherCode), request.TeacherCode);
            }

            request.User.TeacherCode = request.TeacherCode;

            await _dbContext.SaveChangesAsync(cancellationToken);
        }
    }
}
