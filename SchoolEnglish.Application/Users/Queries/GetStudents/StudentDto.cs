using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Users.Queries.GetStudents
{
    public class StudentDto : IMapWith<User>
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public string Email { get; set; }
        public string TeacherCode { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<User, StudentDto>()
                .ForMember(studentDto => studentDto.Id,
                    opt => opt.MapFrom(user => user.Id))
                .ForMember(studentDto => studentDto.Name,
                    opt => opt.MapFrom(user => user.Name))
                .ForMember(studentDto => studentDto.Surname,
                    opt => opt.MapFrom(user => user.Surname))
                .ForMember(studentDto => studentDto.Email,
                    opt => opt.MapFrom(user => user.Email))
                .ForMember(studentDto => studentDto.TeacherCode,
                    opt => opt.MapFrom(user => user.TeacherCode));
        }
    }
}
