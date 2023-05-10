using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.TaskPartsContentTypes.Queries
{
    public class TaskPartContentTypeDto : IMapWith<TaskPartContentType>
    {
        public Guid Id { get; set; }
        public string Name { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<TaskPartContentType, TaskPartContentTypeDto>()
                .ForMember(typeDto => typeDto.Id,
                    opt => opt.MapFrom(type => type.Id))
                .ForMember(typeDto => typeDto.Name,
                    opt => opt.MapFrom(type => type.Name));
        }
    }
}
