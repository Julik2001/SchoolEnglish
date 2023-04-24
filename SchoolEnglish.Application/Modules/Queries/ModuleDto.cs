using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Modules.Queries
{
    public class ModuleDto : IMapWith<Module>
    {
        public Guid Id { get; set; }
        public string? Number { get; set; }
        public string Name { get; set; }
        public Guid? ParentId { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<Module, ModuleDto>()
                .ForMember(moduleDto => moduleDto.Id,
                    opt => opt.MapFrom(module => module.Id))
                .ForMember(moduleDto => moduleDto.Number,
                    opt => opt.MapFrom(module => module.Number))
                .ForMember(moduleDto => moduleDto.Name,
                    opt => opt.MapFrom(module => module.Name))
                .ForMember(moduleDto => moduleDto.ParentId,
                    opt => opt.MapFrom(module => module.ParentId));
        }
    }
}
