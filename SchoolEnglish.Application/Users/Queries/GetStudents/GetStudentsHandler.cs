using AutoMapper;
using AutoMapper.QueryableExtensions;
using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Helpers;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Users.Queries.GetStudents
{
    public class GetStudentsHandler : IRequestHandler<GetStudentsQuery, StudentsVm>
    {
        private readonly ISchoolEnglishDbContext _dbContext;
        private readonly IMapper _mapper;

        public GetStudentsHandler(ISchoolEnglishDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<StudentsVm> Handle(GetStudentsQuery request, CancellationToken cancellationToken)
        {
            var students = await _dbContext.Users.Where(user =>
                user.TeacherCode == request.TeacherCode && user.RoleId == BaseRolesHelper.StudentRole.Id)
                .ProjectTo<StudentDto>(_mapper.ConfigurationProvider)
                .ToListAsync(cancellationToken);

            return new StudentsVm { Students = students };
        }
    }
}
