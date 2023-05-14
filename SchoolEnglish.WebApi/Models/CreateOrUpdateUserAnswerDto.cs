using AutoMapper;
using SchoolEnglish.Application.Common.Mappings;
using SchoolEnglish.Application.UserAnswers.Commands.CreateOrUpdateUserAnswer;

namespace SchoolEnglish.WebApi.Models
{
    public class CreateOrUpdateUserAnswerDto : IMapWith<CreateOrUpdateUserAnswerCommand>
    {
        public string Answer { get; set; }
        public Guid TaskPartId { get; set; }
        public Guid UserId { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<CreateOrUpdateUserAnswerDto, CreateOrUpdateUserAnswerCommand>()
                .ForMember(moduleCommand => moduleCommand.Answer,
                    opt => opt.MapFrom(moduleDto => moduleDto.Answer))
                .ForMember(moduleCommand => moduleCommand.TaskPartId,
                    opt => opt.MapFrom(moduleDto => moduleDto.TaskPartId))
                .ForMember(moduleCommand => moduleCommand.UserId,
                    opt => opt.MapFrom(moduleDto => moduleDto.UserId));
        }
    }
}
