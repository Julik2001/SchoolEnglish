using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Application.Users.Commands.CreateUser;

namespace SchoolEnglish.WebApi.Models
{
    public class RegisterUserDto : IMapWith<CreateUserCommand>
    {
        public string Name { get; set; }
        public string Surname { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public Guid RoleId { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<RegisterUserDto, CreateUserCommand>()
                .ForMember(userCommand => userCommand.Name,
                    opt => opt.MapFrom(userDto => userDto.Name))
                .ForMember(userCommand => userCommand.Surname,
                    opt => opt.MapFrom(userDto => userDto.Surname))
                .ForMember(userCommand => userCommand.Email,
                    opt => opt.MapFrom(userDto => userDto.Email))
                .ForMember(userCommand => userCommand.Password,
                    opt => opt.MapFrom(userDto => userDto.Password))
                .ForMember(userCommand => userCommand.RoleId,
                    opt => opt.MapFrom(userDto => userDto.RoleId));
        }
    }
}
