using MediatR;

namespace SchoolEnglish.Application.TaskPartsContentTypes.Queries.CheckContentTypeHasAudio
{
    public class CheckContentTypeHasAudioQuery : IRequest<bool>
    {
        public Guid TypeId { get; set; }
    }
}
