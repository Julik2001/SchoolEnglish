using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.TaskParts.Queries
{
    public class TaskPartVm : IMapWith<TaskPart>
    {
        public Guid Id { get; set; }
        public string Number { get; set; }
        public string RightAnswer { get; set; }
        public string ClueText { get; set; }
        public int ClueCost { get; set; }
        public Guid TaskId { get; set; }
        public TaskPartContentVm Content { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<TaskPart, TaskPartVm>()
                .ForMember(taskPartVm => taskPartVm.Id,
                opt => opt.MapFrom(taskPart => taskPart.Id))
                .ForMember(taskPartVm => taskPartVm.Number,
                opt => opt.MapFrom(taskPart => taskPart.Number))
                .ForMember(taskPartVm => taskPartVm.RightAnswer,
                opt => opt.MapFrom(taskPart => taskPart.RightAnswer))
                .ForMember(taskPartVm => taskPartVm.ClueText,
                opt => opt.MapFrom(taskPart => taskPart.ClueText))
                .ForMember(taskPartVm => taskPartVm.TaskId,
                opt => opt.MapFrom(taskPart => taskPart.TaskId))
                .ForMember(taskPartVm => taskPartVm.Content,
                opt => opt.MapFrom(taskPart => taskPart.Content));
        }
    }
}
