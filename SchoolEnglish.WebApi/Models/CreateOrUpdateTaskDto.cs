using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Application.Tasks.Commands.CreateOrUpdateTask;

namespace SchoolEnglish.WebApi.Models
{
    public class CreateOrUpdateTaskDto : IMapWith<CreateOrUpdateTaskCommand>
    {
        public Guid? Id { get; set; }
        public string Header { get; set; }
        public int TimeInMinutes { get; set; }
        public int Reward { get; set; }
        public Guid ModuleId { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<CreateOrUpdateTaskDto, CreateOrUpdateTaskCommand>()
                .ForMember(taskCommand => taskCommand.Id,
                    opt => opt.MapFrom(taskDto => taskDto.Id))
                .ForMember(taskCommand => taskCommand.Header,
                    opt => opt.MapFrom(taskDto => taskDto.Header))
                .ForMember(taskCommand => taskCommand.TimeInMinutes,
                    opt => opt.MapFrom(taskDto => taskDto.TimeInMinutes))
                .ForMember(taskCommand => taskCommand.Reward,
                    opt => opt.MapFrom(taskDto => taskDto.Reward))
                .ForMember(taskCommand => taskCommand.ModuleId,
                    opt => opt.MapFrom(taskDto => taskDto.ModuleId));
        }
    }
}
