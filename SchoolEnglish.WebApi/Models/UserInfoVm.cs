using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Domain;

namespace SchoolEnglish.WebApi.Models
{
    public class UserInfoVm : IMapWith<User>
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public string Email { get; set; }
        public string TeacherCode { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<User, UserInfoVm>()
                .ForMember(userDto => userDto.Id,
                    opt => opt.MapFrom(user => user.Id))
                .ForMember(userDto => userDto.Name,
                    opt => opt.MapFrom(user => user.Name))
                .ForMember(userDto => userDto.Surname,
                    opt => opt.MapFrom(user => user.Surname))
                .ForMember(userDto => userDto.Email,
                    opt => opt.MapFrom(user => user.Email))
                .ForMember(userDto => userDto.TeacherCode,
                    opt => opt.MapFrom(user => user.TeacherCode));
        }
    }
}
