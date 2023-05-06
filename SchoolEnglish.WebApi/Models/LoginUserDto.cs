using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Application.Users.Queries.GetUserByEmailAndPassword;
using SchoolEnglish.Domain;

namespace SchoolEnglish.WebApi.Models
{
    public class LoginUserDto : IMapWith<User>
    {
        public string Email { get; set; }
        public string Password { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<LoginUserDto, GetUserByEmailAndPasswordQuery>()
                .ForMember(userQuery => userQuery.Email,
                    opt => opt.MapFrom(userDto => userDto.Email))
                .ForMember(userQuery => userQuery.Password,
                    opt => opt.MapFrom(userDto => userDto.Password));
        }
    }
}
