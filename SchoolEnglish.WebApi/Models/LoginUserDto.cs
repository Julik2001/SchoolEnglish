using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Users.Queries.GetUser
{
    public class LoginUserDto : IMapWith<User>
    {
        public string Email { get; set; }
        public string Password { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<LoginUserDto, GetUserQuery>()
                .ForMember(userQuery => userQuery.Email,
                    opt => opt.MapFrom(userDto => userDto.Email))
                .ForMember(userQuery => userQuery.Password,
                    opt => opt.MapFrom(userDto => userDto.Password));
        }
    }
}
