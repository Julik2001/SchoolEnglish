using MediatR;
using SchoolEnglish.Application.Common.Helpers;

namespace SchoolEnglish.Application.TaskPartsContentTypes.Queries.CheckContentTypeHasAudio
{
    public class CheckContentTypeHasAudioHandler : IRequestHandler<CheckContentTypeHasAudioQuery, bool>
    {
        public async Task<bool> Handle(CheckContentTypeHasAudioQuery request, CancellationToken cancellationToken)
        {
            return BaseTaskPartContentTypesHelper.GetTypesWithAudio().Any(type => type.Id == request.TypeId);
        }
    }
}
