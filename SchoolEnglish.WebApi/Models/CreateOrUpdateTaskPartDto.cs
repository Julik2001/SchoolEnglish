using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Application.TaskParts.Commands.CreateOrUpdateTaskPart;

namespace SchoolEnglish.WebApi.Models
{
    public class CreateOrUpdateTaskPartDto : IMapWith<CreateOrUpdateTaskPartCommand>
    {
        public Guid? Id { get; set; }
        public string Number { get; set; }
        public string RightAnswer { get; set; }
        public string ClueText { get; set; }
        public int ClueCost { get; set; }
        public Guid TaskId { get; set; }
        public string? TextToRead { get; set; }
        public string? Text { get; set; }
        public string? AnswerVariants { get; set; }
        public Guid TypeId { get; set; }
        public IFormFile? ImageFile { get; set; }
        public IFormFile? AudioFile { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<CreateOrUpdateTaskPartDto, CreateOrUpdateTaskPartCommand>()
                .ForMember(taskPartCommand => taskPartCommand.Id,
                    opt => opt.MapFrom(taskPartDto => taskPartDto.Id))
                .ForMember(taskPartCommand => taskPartCommand.Number,
                    opt => opt.MapFrom(taskPartDto => taskPartDto.Number))
                .ForMember(taskPartCommand => taskPartCommand.RightAnswer,
                    opt => opt.MapFrom(taskPartDto => taskPartDto.RightAnswer))
                .ForMember(taskPartCommand => taskPartCommand.ClueText,
                    opt => opt.MapFrom(taskPartDto => taskPartDto.ClueText))
                .ForMember(taskPartCommand => taskPartCommand.ClueCost,
                    opt => opt.MapFrom(taskPartDto => taskPartDto.ClueCost))
                .ForMember(taskPartCommand => taskPartCommand.TaskId,
                    opt => opt.MapFrom(taskPartDto => taskPartDto.TaskId));
        }
    }
}
