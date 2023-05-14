using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Tasks.Queries.GetTask
{
    public class TaskVm : IMapWith<Domain.Task>
    {
        public Guid Id { get; set; }
        public string Header { get; set; }
        public int TimeInMinutes { get; set; }
        public int Reward { get; set; }
        public Guid ModuleId { get; set; }
        public IEnumerable<TaskPart> Parts { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<Domain.Task, TaskVm>()
                .ForMember(taskVm => taskVm.Id,
                opt => opt.MapFrom(task => task.Id))
                .ForMember(taskVm => taskVm.TimeInMinutes,
                opt => opt.MapFrom(task => task.TimeInMinutes))
                .ForMember(taskVm => taskVm.Header,
                opt => opt.MapFrom(task => task.Header))
                .ForMember(taskVm => taskVm.Reward,
                opt => opt.MapFrom(task => task.Reward))
                .ForMember(taskVm => taskVm.ModuleId,
                opt => opt.MapFrom(task => task.ModuleId))
                .ForMember(taskVm => taskVm.Parts,
                opt => opt.MapFrom(task => task.Parts));
        }
    }
}
