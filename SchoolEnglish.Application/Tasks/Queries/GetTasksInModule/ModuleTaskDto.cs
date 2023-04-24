using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Tasks.Queries.GetTasksInModule
{
    public class ModuleTaskDto : IMapWith<Domain.Task>
    {
        public Guid Id { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<Domain.Task, ModuleTaskDto>()
                .ForMember(moduleTaskDto => moduleTaskDto.Id,
                    opt => opt.MapFrom(task => task.Id));
        }
    }
}
