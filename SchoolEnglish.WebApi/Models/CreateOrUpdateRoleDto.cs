using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Application.Roles.Commands.CreateOrUpdateRole;

namespace SchoolEnglish.WebApi.Models
{
    public class CreateOrUpdateRoleDto : IMapWith<CreateOrUpdateRoleCommand>
    {
        public string Name { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<CreateOrUpdateRoleDto, CreateOrUpdateRoleCommand>()
                .ForMember(moduleCommand => moduleCommand.Name,
                    opt => opt.MapFrom(moduleDto => moduleDto.Name));
        }
    }
}
