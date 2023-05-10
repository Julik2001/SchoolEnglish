using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.TaskParts.Queries
{
    public class TaskPartContentVm : IMapWith<TaskPartContent>
    {
        public Guid Id { get; set; }
        public string? Text { get; set; }
        public string? TextToRead { get; set; }
        public string? AnswerVariants { get; set; }
        public string? ImagePath { get; set; }
        public string? AudioPath { get; set; }
        public Guid TypeId { get; set; }
        public Guid TaskPartId { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<TaskPartContent, TaskPartContentVm>()
                .ForMember(contentVm => contentVm.Id,
                opt => opt.MapFrom(content => content.Id))
                .ForMember(contentVm => contentVm.Text,
                opt => opt.MapFrom(content => content.Text))
                .ForMember(contentVm => contentVm.TextToRead,
                opt => opt.MapFrom(content => content.TextToRead))
                .ForMember(contentVm => contentVm.AnswerVariants,
                opt => opt.MapFrom(content => content.AnswerVariants))
                .ForMember(contentVm => contentVm.ImagePath,
                opt => opt.MapFrom(content => content.ImagePath))
                .ForMember(contentVm => contentVm.AudioPath,
                opt => opt.MapFrom(content => content.AudioPath))
                .ForMember(contentVm => contentVm.TypeId,
                opt => opt.MapFrom(content => content.TypeId))
                .ForMember(contentVm => contentVm.TaskPartId,
                opt => opt.MapFrom(content => content.TaskPartId));
        }
    }
}
