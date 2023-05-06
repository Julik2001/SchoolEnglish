using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Application.Modules.Commands.CreateOrUpdateModule;

namespace SchoolEnglish.WebApi.Models
{
    public class CreateOrUpdateModuleDto : IMapWith<CreateOrUpdateModuleCommand>
    {
        public Guid? Id { get; set; }
        public string? Number { get; set; }
        public string Name { get; set; }
        public Guid? ParentId { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<CreateOrUpdateModuleDto, CreateOrUpdateModuleCommand>()
                .ForMember(moduleCommand => moduleCommand.Id, 
                    opt => opt.MapFrom(moduleDto => moduleDto.Id))
                .ForMember(moduleCommand => moduleCommand.Number,
                    opt => opt.MapFrom(moduleDto => moduleDto.Number))
                .ForMember(moduleCommand => moduleCommand.Name,
                    opt => opt.MapFrom(moduleDto => moduleDto.Name))
                .ForMember(moduleCommand => moduleCommand.ParentId,
                    opt => opt.MapFrom(moduleDto => moduleDto.ParentId));
        }
    }
}
