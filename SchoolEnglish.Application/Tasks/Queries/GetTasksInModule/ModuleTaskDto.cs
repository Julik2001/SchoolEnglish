using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;

namespace SchoolEnglish.Application.Tasks.Queries.GetTasksInModule
{
    public class ModuleTaskDto : IMapWith<Domain.Task>
    {
        public Guid Id { get; set; }
        public string Header { get; set; }
        public int Reward { get; set; }
        public Guid ModuleId { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<Domain.Task, ModuleTaskDto>()
                .ForMember(moduleTaskDto => moduleTaskDto.Id,
                    opt => opt.MapFrom(task => task.Id))
                .ForMember(moduleTaskDto => moduleTaskDto.Header,
                    opt => opt.MapFrom(task => task.Header))
                .ForMember(moduleTaskDto => moduleTaskDto.Reward,
                    opt => opt.MapFrom(task => task.Reward))
                .ForMember(moduleTaskDto => moduleTaskDto.ModuleId,
                    opt => opt.MapFrom(task => task.ModuleId));
        }
    }
}
